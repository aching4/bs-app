//
//  GroupViewModel.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//  Code by Suzanna L on 5/12/24


import Foundation
import SwiftUI

class GroupsViewModel: ObservableObject {
    @Published var groups: [String]
    @Published var isGroup: Bool = false
    
    init() {
        //list of current splits
        groups = ["Group 1", "Group 2"]
    }
    
    //add bill to current splits
    func addToGroup(_ groups: String) {
        self.groups.append(groups)
    }
    
}
