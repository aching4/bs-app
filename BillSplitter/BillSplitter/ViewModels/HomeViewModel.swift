//
//  HomeViewModel.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//  Code by Suzanna L on 5/12/24


import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var currentSplits: [String]
    
    init() {
        //list of current splits
        currentSplits = ["Bill 1", "Bill 2"]
    }
    
    //add bill to current splits
    func addBill(_ currentSplits: String) {
        self.currentSplits.append(currentSplits)
    }
    
}
