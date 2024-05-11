//
//  IndividualBillView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import Foundation
import SwiftUI

struct IndividualBillView: View {
    @State private var dishes: [Dish] = [Dish(name: "", price: 0.0)]
    @State private var tax: String = ""
    @State private var tip: String = ""
    var personName: String = "Person Name"

    var total: Double {
        let totalDishPrice = dishes.reduce(0) { $0 + $1.price }
        let totalTax = Double(tax) ?? 0.0
        let totalTip = Double(tip) ?? 0.0
        return totalDishPrice + totalTax + totalTip
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($dishes.indices, id: \.self) { index in
                        DishView(dish: $dishes[index])
                    }
                    .onDelete(perform: removeDishes)
                    
                    HStack {
                        Text("Tax:")
                        Spacer()
                        TextField("$", text: $tax)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Tip:")
                        Spacer()
                        TextField("$", text: $tip)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Total:")
                        Spacer()
                        Text("$\(total, specifier: "%.2f")")
                    }
                }
                
                Button(action: addDish) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                }
            }
            .navigationBarTitle(Text(personName))
        }
    }

    func addDish() {
        dishes.append(Dish(name: "", price: 0.0))
    }
    
    func removeDishes(at offsets: IndexSet) {
        dishes.remove(atOffsets: offsets)
    }
}

struct Dish: Identifiable {
    let id = UUID()
    var name: String
    var price: Double
}

struct DishView: View {
    @Binding var dish: Dish
    
    var body: some View {
        HStack {
            TextField("Dish Name", text: $dish.name)
            Spacer()
            TextField("$", value: $dish.price, formatter: NumberFormatter())
                .keyboardType(.decimalPad)
        }
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView()
    }
}
