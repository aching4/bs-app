//
//  FriendsViewModel.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//  Code by Suzanna L on 5/12/24


import Foundation
import SwiftUI

class FriendsViewModel: ObservableObject {
    @Published var friends: [String]
    @Published var isFriend: Bool = false
    
    init() {
        //list of current splits
        friends = ["Friend 1", "Friend 2"]
    }
    
    //add bill to current splits
    func addFriend(_ friends: String) {
        self.friends.append(friends)
    }
    
}
