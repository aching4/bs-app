//
//  AddBillView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import Foundation
import SwiftUI

struct AddBillView: View {
    @State private var billTitle: String = ""
    @State private var placeName: String = ""
    @State private var groupName: String = ""
    @State private var groups: [String] = ["Family", "Friends", "Work"] // Example groups
    @State private var friends: [String] = ["Alice", "Bob", "Charlie"] // Example friends
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Bill Info")) {
                    TextField("Bill Title", text: $billTitle)
                    TextField("Name of Place", text: $placeName)
                    Picker("Group Name", selection: $groupName) {
                        ForEach(groups, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section(header: Text("Items")) {
                    ForEach(0..<5) { _ in // Example for 5 items
                        HStack {
                            TextField("Item Name", text: .constant(""))
                            Spacer()
                            TextField("$", text: .constant(""))
                        }
                    }
                    Button(action: {
                        // Action to take a picture
                    }) {
                        Text("Take A Picture")
                    }
                }
                
                Section(header: Text("Shares")) {
                    ForEach(friends, id: \.self) { friend in
                        PersonShareView(friendName: friend)
                    }
                }
                
                Button(action: {
                    // Action to add more people/dishes
                }) {
                    Image(systemName: "plus")
                    Text("Add More")
                }
            }
            .navigationBarTitle("Add Bill", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                // Action to cancel
            }, trailing: Button("Save") {
                // Action to save the bill
            })
        }
    }
}

struct PersonShareView: View {
    var friendName: String
    @State private var total: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(friendName).font(.headline)
            ForEach(0..<3) { _ in // Example for 3 dishes
                HStack {
                    TextField("Dish Name", text: .constant(""))
                    Spacer()
                    TextField("$", text: .constant(""))
                }
            }
            HStack {
                TextField("Tax", text: .constant(""))
                Spacer()
                TextField("Tip", text: .constant(""))
                Spacer()
                TextField("Total", text: $total)
            }
        }
    }
}

struct AddBillView_Previews: PreviewProvider {
    static var previews: some View {
        AddBillView()
    }
}

