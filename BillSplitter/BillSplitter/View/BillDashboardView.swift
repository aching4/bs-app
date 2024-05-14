//
//  BillDashboardView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
// 

import SwiftUI

struct BillDashboardView: View {
    @StateObject private var viewModel = BillDashboardViewModel()

    var body: some View {
        VStack {
            // Header section for bill information
            VStack(alignment: .center) {
                Text(viewModel.billName)
                    .font(.title)
                    .padding(.top, 20)
                Text(viewModel.establishmentName)
                    .font(.subheadline)
                Text("Total: \(viewModel.totalAmount, specifier: "%.2f") $")
                    .font(.headline)
                    .padding(.bottom, 20)
            }

            // List of friends and the amount they owe
            List {
                ForEach(viewModel.friends) { friend in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(friend.name)
                            Text("Owe: $\(friend.amountOwed, specifier: "%.2f")")
                        }
                        Spacer()
                        // Displaying payment status with a single star
                        Image(systemName: friend.hasPaid ? "star.fill" : "star")
                            .foregroundColor(friend.hasPaid ? .yellow : .gray)
                    }
                    .padding(.vertical, 10)
                }
            }
            .listStyle(PlainListStyle())

            // Button to add a new friend
            Button(action: {
                // Action to add new friend
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .padding(.top, 20)
            }

            Spacer()

            // Navigation bar with placeholder icons
            HStack {
                Image(systemName: "house")
                Spacer()
                Image(systemName: "person.2")
                Spacer()
                Image(systemName: "person.3")
                Spacer()
                Image(systemName: "person.crop.circle")
            }
            .font(.title2)
            .padding()
            .background(Color.gray.opacity(0.2))
        }
        .navigationBarHidden(true)
    }
}

struct BillDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        BillDashboardView()
    }
}

