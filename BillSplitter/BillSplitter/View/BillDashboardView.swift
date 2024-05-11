//
//  BillDashboardView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import Foundation
import SwiftUI

struct BillDashboardView: View {
    let billName: String = "Bill Name"
    let establishmentName: String = "Name of Establishment"
    let totalAmount: Double = 120.0 // example total

    // Sample data for friends and amounts they owe
    var friends: [Friend] = [
        Friend(name: "Alice", oweAmount: 20.0, hasPaid: true),
        Friend(name: "Bob", oweAmount: 30.0, hasPaid: false),
        Friend(name: "Charlie", oweAmount: 25.0, hasPaid: true),
        Friend(name: "David", oweAmount: 45.0, hasPaid: false)
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text(billName).font(.headline)
                Text(establishmentName).font(.subheadline)
                Text("Total: $\(totalAmount, specifier: "%.2f")").bold()
                List {
                    ForEach(friends) { friend in
                        HStack {
                            Text(friend.name)
                            Spacer()
                            Text("Owe: $\(friend.oweAmount, specifier: "%.2f")")
                            Spacer()
                            PaymentStatusView(hasPaid: friend.hasPaid)
                        }
                    }
                }
            }
            .navigationTitle("Bill Summary")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Action for adding new items/friends
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct Friend: Identifiable {
    let id = UUID()
    let name: String
    let oweAmount: Double
    let hasPaid: Bool
}

struct PaymentStatusView: View {
    var hasPaid: Bool
    var body: some View {
        if hasPaid {
            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
        } else {
            Image(systemName: "xmark.circle.fill").foregroundColor(.red)
        }
    }
}

@main
struct BillApp: App {
    var body: some Scene {
        WindowGroup {
            BillSummaryView()
        }
    }
}
