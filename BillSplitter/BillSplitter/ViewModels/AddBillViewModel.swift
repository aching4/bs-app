//
//  AddBillViewModel.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//
import Foundation

// Define the BillItem struct
struct BillItem: Identifiable {
    let id = UUID()
    var itemName: String
    var price: Double
}

// Define the FriendShare struct
struct FriendShare: Identifiable {
    let id = UUID()
    var name: String
    var items: [BillItem]
    var tax: Double
    var tip: Double
}

class AddBillViewModel: ObservableObject {
    @Published var billTitle: String = ""
    @Published var placeName: String = ""
    @Published var groupName: String = ""
    @Published var groups: [String] = ["Family", "Friends", "Work"]
    @Published var friendsShares: [FriendShare] = [
        FriendShare(name: "Me", items: [], tax: 0, tip: 0),
    ]

    func addNewFriend() {
        let newFriend = FriendShare(name: "New Friend", items: [], tax: 0, tip: 0)
        friendsShares.append(newFriend)
    }

    func addItem(for friend: FriendShare) {
        if let index = friendsShares.firstIndex(where: { $0.name == friend.name }) {
            friendsShares[index].items.append(BillItem(itemName: "", price: 0))
        }
    }

    func addPlaceName(_ name: String){
        placeName = name
    }

    func addGroupName(_ group: String){
        groupName = group
    }

    func addBillTitle(_ title: String){
        billTitle = title
    }
}


