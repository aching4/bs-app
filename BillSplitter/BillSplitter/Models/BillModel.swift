import Foundation

struct BillItem {
    var dishName: String
    var price: Double
}

struct Bill {
    var name: String
    var items: [BillItem]
    var tax: Double
    var tip: Double
    var total: Double {
        // Calculate the total dynamically
        let itemTotal = items.reduce(0) { $0 + $1.price }
        return itemTotal + tax + tip
    }
}