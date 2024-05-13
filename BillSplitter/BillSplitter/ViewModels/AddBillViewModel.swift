//
//  AddBillViewModel.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

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
}


