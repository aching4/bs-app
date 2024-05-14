//
//  BillDashboardViewModel.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import Foundation

struct FriendOwed: Identifiable {
    var id: UUID = UUID()
    var name: String
    var amountOwed: Double
    var hasPaid: Bool
}

class BillDashboardViewModel: ObservableObject {
    @Published var billName: String = "Bill Name"
    @Published var establishmentName: String = "Name of Establishment"
    @Published var totalAmount: Double = 0
    @Published var friends: [FriendOwed] = [
    ]
}
