//
//  BillDashboardView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import SwiftUI

struct BillDashboardView: View {
    @StateObject private var viewModel = BillDashboardViewModel()
    @StateObject private var viewModel1 = AddBillViewModel() 

    var body: some View {
        VStack {
            // Bill header information
            Text(viewModel.billName).font(.title)
            Text(viewModel.establishmentName).font(.subheadline)
            Text("Total: \(viewModel.totalAmount, specifier: "%.2f") $").font(.headline)
            
            // List of friends and the amount they owe
            List(viewModel.friends) { friend in
                HStack {
                    VStack(alignment: .leading) {
                        Text(friend.name)
                        Text("Owe: $\(friend.amountOwed, specifier: "%.2f")")
                    }
                    Spacer()
                    PaidStatusView(hasPaid: friend.hasPaid)
                }
            }
            .listStyle(PlainListStyle())

            Spacer()
            
            // Add new friend button
            Button(action: {
                // Implement add new friend logic
            }) {
                Image(systemName: "plus")
            }
            .padding()

            // Bottom navigation bar
            HStack {
                Image(systemName: "house")
                Spacer()
                Image(systemName: "person.2")
                Spacer()
                Image(systemName: "person.3")
                Spacer()
                Image(systemName: "person.crop.circle")
            }
            .padding()
            .background(Color.gray.opacity(0.2))
        }
    }
}

struct BillDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        BillDashboardView()
    }
}
