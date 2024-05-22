//
//  IndividualBillView.swift
//  BillSplitter_Test
//
//  
//

import Foundation
import SwiftUI

struct IndividualBillView: View {
    @EnvironmentObject private var sharedData: SharedData
    @State private var people: [Person] = []
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                Text("Individual Bills").font(.largeTitle)
                
                ScrollView {
                    HStack{
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(0..<people.count, id: \.self) { index in
                                // Card View
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(people[index].name + ": $\(String(format: "%.2f", people[index].total))")
                                        .font(.title2)
                                        .bold()
                                    Text("Breakdown:")
                                        .font(.title2)
                                    ForEach(0..<people[index].items.count, id: \.self) { i in
                                        Text("\(people[index].items[i].name): $\(String(format: "%.2f", people[index].items[i].price))")
                                            .font(.title3)
                                        Text("Fee: $\(String(format: "%.2f", people[index].fee))")
                                            .font(.title3)
                                        Text("Tax: $\(String(format: "%.2f", people[index].tax))")
                                            .font(.title3)
                                        Text("Tip: $\(String(format: "%.2f", people[index].tip))")
                                            .font(.title3)
                                    }
                                }
                                .padding(10)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                .background(Color.white)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            }
        }
        .onAppear {
            people = splitBill(sharedData.entries, fee: sharedData.fee, tax: sharedData.tax, tip: sharedData.tip)
        }
    }
}

struct IndividualBillView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualBillView()
    }
}
