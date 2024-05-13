//
//  AddBillView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

struct AddBillView: View {
    @StateObject private var viewModel = AddBillViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Bill Info")) {
                    TextField("Bill Title", text: Binding(
                        get: { viewModel.billTitle },
                        set: { viewModel.addBillTitle($0) }
                    ))
                    TextField("Name of Place", text: Binding(
                        get: { viewModel.placeName },
                        set: { viewModel.addPlaceName($0) }
                    ))
                    Picker("Group Name", selection: Binding(
                        get: { viewModel.groupName },
                        set: { viewModel.addGroupName($0) }
                    )) {
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
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                // Implement save functionality or call a viewModel function to save data
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddBillView_Previews: PreviewProvider {
    static var previews: some View {
        AddBillView()
    }
}

