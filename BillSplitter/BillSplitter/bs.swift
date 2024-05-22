//
//  bs.swift
//  BillSplitter
//
//  Created by Ashley C on 5/21/24.
//

import Foundation

typealias Entry = (names: [String], price: Double, item: String)
typealias BundledGoods = (entries: [Entry], fee: Double?, tax: Double?, tip: Double?)

class Item: CustomStringConvertible    {
    var price: Double
    var name: String

    init(price: Double, name: String) {
        self.price = price
        self.name = name
    }

    var description: String {
        return "Name: \(self.name), Price: $\(String(format: "%.2f", self.price))"
    }
}

class Person: CustomStringConvertible    {
    var name: String
    var items: [Item]
    
    var fee: Double
    var tax: Double
    var tip: Double

    var total: Double

    init(name: String, items: [Item]) {
        self.name = name
        self.items = items
        self.fee = 0
        self.tax = 0
        self.tip = 0
        self.total = 0
    }

    func addItem(_ incomingItem: Item) {
        var found: Bool = false

        // add to existing item
        for item: Item in self.items {
            if item.name == incomingItem.name {
                item.price += incomingItem.price
                found = true
                break
            }
        }

        // item does not exist, create new entry
        if !found {
            self.items.append(incomingItem)
        }
    }

    func update(
        _ subtotal: Double,
        fee: Double = 0,
        fee_mode: String = "$",
        tax: Double = 0,
        tax_mode: String = "$",
        tip: Double = 0,
        tip_mode: String = "$"
    ) {
        // subtotal
        self.total = self.items.reduce(0) { $0 + $1.price }
        
        // update fee, tax, and tip percent
        var fee_percent: Double = 0
        var tax_percent: Double = 0
        var tip_percent: Double = 0
        if fee_mode == "$" {
            fee_percent = fee / subtotal
        } else if fee_mode == "%" {
            fee_percent = fee / 100
        }
        if tax_mode == "$" {
            tax_percent = tax / subtotal
        } else if tax_mode == "%" {
            tax_percent = tax / 100
        }
        if tip_mode == "$" {
            tip_percent = tip / subtotal
        } else if tip_mode == "%" {
            tip_percent = tip / 100
        }

        // update fee, tax, and tip amount
        self.fee = self.total * fee_percent
        self.tax = self.total * tax_percent
        self.tip = self.total * tip_percent

        // round to 2 decimal places
        self.fee = Double(String(format: "%.2f", self.fee)) ?? self.fee
        self.tax = Double(String(format: "%.2f", self.tax)) ?? self.tax
        self.tip = Double(String(format: "%.2f", self.tip)) ?? self.tip

        // total
        self.total += self.fee + self.tax + self.tip
    }

    var description: String {
        var output: String = "";
        output += "\(self.name): $\(String(format: "%.2f", self.total))\n"
        output += "\tFee: $\(String(format: "%.2f", self.fee))\n"
        output += "\tTax: $\(String(format: "%.2f", self.tax))\n"
        output += "\tTip: $\(String(format: "%.2f", self.tip))\n"
        output += "\tItems: [\(self.items.map { $0.description }.joined(separator: ", "))]"
        return output
    }
}

func calculateSubtotal(_ entries: [Entry]) -> Double {
    return entries.reduce(0) { $0 + $1.price }
}

func convertDollarToPercent(dollar: Double, subtotal: Double) -> Double {
    return dollar / subtotal * 100
}

func convertPercentToDollar(percent: Double, subtotal: Double) -> Double {
    return percent * subtotal / 100
}

func splitBill(
    _ entries: [Entry],
    fee: Double = 0,
    fee_mode: String = "$",
    tax: Double = 0,
    tax_mode: String = "$",
    tip: Double = 0,
    tip_mode: String = "$"
) -> [Person] {
    var people: [Person] = []
    var subtotal: Double = 0
    
    // processes data
    for entry: Entry in entries {
        let names: [String] = entry.names
        let price: Double = entry.price
        let item: String = entry.item

        subtotal += price

        for name: String in names {
            let label: String = item + (names.count > 1 ? " [Split]" : "")
            let unformatPrice: Double = price / Double(names.count)
            let finalPrice: Double = Double(String(format: "%.2f", unformatPrice)) ?? unformatPrice

            if let person: Person = people.first(where: { $0.name == name }) {
                person.addItem(Item(price: finalPrice, name: label))
            } else {
                people.append(Person(name: name, items: [Item(price: finalPrice, name: label)]))
            }
        }
    }

    // update fee, tax, tip, and total
    for person: Person in people {
        person.update(subtotal, fee: fee, fee_mode: fee_mode, tax: tax, tax_mode: tax_mode, tip: tip, tip_mode: tip_mode)
    }

    return people
}

func urlToEntries(url: String) -> BundledGoods {
    var entries: [Entry] = []
    var fee: Double?
    var tax: Double?
    var tip: Double?

    if let urlComponents: URLComponents = URLComponents(string: url) {
        if let queryItems: [URLQueryItem] = urlComponents.queryItems {
            var parsedParameters: [String : [String]] = [String: [String]]()
            
            for item: URLQueryItem in queryItems {
                if let value: String = item.value {
                    if let data: Data = value.data(using: .utf8),
                        let jsonArray: [String] = try? JSONSerialization.jsonObject(with: data, options: []) as? [String] {
                            parsedParameters[item.name] = jsonArray
                    }
                }
            }
            

            if let range = parsedParameters.values.max(by: { $0.count < $1.count })?.count {
                for i in 0..<range {
                    var price: Double = 0
                    var names: [String] = []
                    var item: String = ""

                    if let p: String = parsedParameters["prices"]?[i] {
                        price = Double(p) ?? 0
                    }
                    if let p: String = parsedParameters["names"]?[i] {
                        names = p.components(separatedBy: ", ")
                    }
                    if let p: String = parsedParameters["items"]?[i] {
                        item = p
                    }

                    entries.append((names, price, item))
                }
            }

            if let p: [String] = parsedParameters["extra"] {
                if p.count == 6 {
                    let subtotal = calculateSubtotal(entries)
                    
                    if p[0] == "$" {
                        fee = Double(p[1])
                    } else {
                        fee = Double(p[1]) == nil ? nil : convertPercentToDollar(percent: Double(p[1]) ?? 0, subtotal: subtotal)
                    }
                    if p[2] == "$" {
                        tax = Double(p[3])
                    } else {
                        tax = Double(p[3]) == nil ? nil : convertPercentToDollar(percent: Double(p[3]) ?? 0, subtotal: subtotal)
                    }
                    if p[4] == "$" {
                        tip = Double(p[5])
                    } else {
                        tip = Double(p[5]) == nil ? nil : convertPercentToDollar(percent: Double(p[5]) ?? 0, subtotal: subtotal)
                    }
                }
            }
        }
    }

    return (entries, fee, tax, tip)
}

func entriesToUrl(_ entries: [Entry], fee: Double, tax: Double, tip: Double) -> String {
    var prices: [Double] = []
    var names: [String] = []
    var items: [String] = []
    let extra: [String] = ["$", fee == 0 ? "" : String(fee), "$", tax == 0 ? "" : String(tax), "$", tip == 0 ? "" : String(tip)]

    for entry: Entry in entries {
        prices.append(entry.price)
        names.append(entry.names.joined(separator: ", "))
        items.append(entry.item)
    }
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "bs.jpkit.us"
    
    var queryItems: [URLQueryItem] = []
    queryItems.append(URLQueryItem(name: "prices", value: prices.description))
    queryItems.append(URLQueryItem(name: "names", value: names.description))
    queryItems.append(URLQueryItem(name: "items", value: items.description))
    queryItems.append(URLQueryItem(name: "extra", value: extra.description))

    urlComponents.queryItems = queryItems

    return urlComponents.string ?? "Failed to generate URL"
}
