//
//  BillDashboardViewModel.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import Foundation

class BillDashboardViewModel: ObservableObject {
    @Published var billName: String = "Bill Name"
    @Published var establishmentName: String = "Name of Establishment"
    @Published var totalAmount: Double = 
    @Published var friends: [FriendOwed] = [
    ]
}