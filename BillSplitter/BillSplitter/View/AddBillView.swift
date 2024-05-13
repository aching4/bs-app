//
//  AddBillView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import SwiftUI

struct AddBillView: View {
    @StateObject private var viewModel = AddBillViewModel()

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Bill Info")) {
                    TextField("Bill Title", text: $viewModel.billTitle)
                    TextField("Name of Place", text: $viewModel.placeName)
                    Picker("Group Name", selection: $viewModel.groupName) {
                        ForEach(viewModel.groups, id: \.self) { group in
                            Text(group)
                        }
                    }
                }

                ForEach(viewModel.friendsShares.indices, id: \.self) { index in
                    Section(header: Text(viewModel.friendsShares[index].name)) {
                        ForEach(viewModel.friendsShares[index].items.indices, id: \.self) { itemIndex in
                            HStack {
                                TextField("Dish Name", text: $viewModel.friendsShares[index].items[itemIndex].itemName)
                                Spacer()
                                TextField("$", value: $viewModel.friendsShares[index].items[itemIndex].price, formatter: NumberFormatter())
                            }
                        }
                        Button("Add Item") {
                            viewModel.addItem(for: viewModel.friendsShares[index])
                        }
                    }
                }
                Button(action: viewModel.addNewFriend) {
                    Label("Add New Friend", systemImage: "plus.circle.fill")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .navigationBarTitle("Add Bill", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                // Cancel action -NEEDS IMPLEMENTATION
            }, trailing: Button("Save") {
                // Save action -NEEDS IMPLEMENTATION
            })
        }
    }
}

struct AddBillView_Previews: PreviewProvider {
    static var previews: some View {
        AddBillView()
    }
}
