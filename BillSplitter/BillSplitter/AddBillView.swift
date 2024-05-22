//
//  AddBillView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/21/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct AddBillView: View {
    @EnvironmentObject private var sharedData: SharedData
    
    @State private var selectedPeople: [String] = []
    @State private var itemName = ""
    @State private var itemPrice: Double?
    @State private var fees: Double?
    @State private var taxes: Double?
    @State private var tips: Double?
    
    @State private var stringURL: String?

    @State private var url = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?

    
    var body: some View {
            ZStack {
                
                VStack {
                    Text("Add Bill")
                        .font(.largeTitle)
                    Form {
                        Section(header: Text("Add From URL").bold().font(.title2)) {
                            TextField("URL", text: $url)
                                .onChange(of: url) {
                                    let info: BundledGoods = urlToEntries(url: url)
                                    print(info)
                                    sharedData.entries = info.entries
                                    sharedData.fee = info.fee ?? 0
                                    sharedData.tax = info.tax ?? 0
                                    sharedData.tip = info.tip ?? 0
                                    fees = info.fee
                                    taxes = info.tax
                                    tips = info.tip
                                }
                        }
                        
                        Section(header: Text("Add From Reciept").bold().font(.title2)) {
                            // Show Images from Album
                            VStack {
                                HStack {
                                    Image(systemName: "photo")
                                        .font(.headline)
                                    
                                    PhotosPicker("Select an image", selection: $selectedItem, matching: .images)
                                        .bold()
                                        .onChange(of: selectedItem) {
                                            Task {
                                                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                                                    image = UIImage(data: data)
                                                }
                                                print("Failed to load the image")
                                            }
                                        } // on change
                                } // hstack
                                .padding(20)
                                .foregroundColor(.black)
                                .background(Color(red: 1, green: 189/255, blue: 189/255))
                                .cornerRadius(8)
                                    
                                if let image = image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                } // image
                            //} // vstack
                            
                            // Show Camera
//                                Text("OR")
//                                    .font(.title2)
                            //VStack {
//                                if let selectedImage{
//                                    Image(uiImage: selectedImage)
//                                        .resizable()
//                                        .scaledToFit()
//                                }
//
//
//
//                                Button(action: {
//                                    self.showCamera.toggle()
//                                }) {
//                                    HStack {
//                                            Image(systemName: "camera")
//                                                .font(.headline)
//                                            Text("Open Camera")
//                                                .fontWeight(.bold)
//                                        }
//                                        .padding(20)
//
//                                        .foregroundColor(.black)
//                                        .background(Color(red: 1, green: 189/255, blue: 189/255))
//
//                                }
//                                .cornerRadius(8)
//                                .fullScreenCover(isPresented: self.$showCamera) {
//                                    accessCameraView(selectedImage: self.$selectedImage)
//                                }
                            }
                        }
                        .background(Color.clear)
                        .edgesIgnoringSafeArea(.all)
                        
                        Section(header: Text("Add Dish").bold().font(.title2)) {
                            TextField("Dish Name", text: $itemName)
                                .padding()
                            TextField("Price", value: $itemPrice, format: .number)
                                .keyboardType(.decimalPad)
                                .padding()
                            List {
                                Text("People Who Ordered This Dish:")
                                    .padding(.horizontal, 10)
                                ForEach(sharedData.peopleNames, id: \.self) { person in
                                    Button(action: {
                                        if selectedPeople.contains(person) {
                                            selectedPeople.removeAll(where: { $0 == person })
                                        } else {
                                            selectedPeople.append(person)
                                        }
                                    }) {
                                        HStack {
                                            Text(person)
                                                .padding(.horizontal, 30)
                                            if selectedPeople.contains(person) {
                                                Spacer()
                                                Image(systemName: "checkmark")
                                            }
                                        }
                                        .foregroundColor(Color(red: 90.6/100, green: 32.9/100, blue: 50.2/100))
                                    }
                                }
                                
                            }
                            
                            
                            Button(action: {
                                if !selectedPeople.isEmpty && (itemPrice ?? 0) != 0 && !itemName.isEmpty {
                                    sharedData.entries.append(Entry(selectedPeople, itemPrice ?? 0, itemName))
                                    selectedPeople.removeAll()
                                    itemPrice = nil
                                    itemName = ""
                                }
                            })
                            {
                                Text("Add Item")
                                    .disabled(selectedPeople.isEmpty || (itemPrice ?? 0) == 0 || itemName.isEmpty)
                                    .padding(.horizontal, 20)
                            }
                                
                        }
                        
                        
                        Section(header: Text("Items").bold().font(.title2)) {
                            ForEach(0..<sharedData.entries.count, id: \.self) { index in
                                HStack {
                                    Text("\(sharedData.entries[index].item): $\(String(format: "%.2f", sharedData.entries[index].price))\n\(sharedData.entries[index].names.joined(separator: ", "))")
                                }
                            }
                            .onDelete { indices in
                                sharedData.entries.remove(atOffsets: indices)
                            }
                        }
                            
                        
                        Section(header: Text("Fees + Taxes + Tips").bold().font(.title2)) {
                            Text("Subtotal: $\(String(format: "%.2f", sharedData.entries.reduce(0) { $0 + $1.price }))")
                                TextField("Fees", value: $fees, format: .number)
                                    .keyboardType(.decimalPad)
                                    .padding()
                                    .onChange(of: fees) {
                                        sharedData.fee = fees ?? 0
                                    }
                                TextField("Taxes", value: $taxes, format: .number)
                                    .keyboardType(.decimalPad)
                                    .padding()
                                    .onChange(of: taxes) {
                                        sharedData.tax = taxes ?? 0
                                    }
                                TextField("Tips", value: $tips, format: .number)
                                    .keyboardType(.decimalPad)
                                    .padding()
                                    .onChange(of: tips) {
                                        sharedData.tip = tips ?? 0
                                    }
                            Text("Total: $\(String(format: "%.2f", sharedData.entries.reduce(0) { $0 + $1.price } + (fees ?? 0) + (taxes ?? 0) + (tips ?? 0)))")
                        }
                        
                        Section(header: Text("Individual Bill").bold().font(.title2)) {
                            NavigationLink("See Individual Bills!", destination: IndividualBillView())
                        }
                    } // form
                    .cornerRadius(20)
                    .padding(20)
                    .scrollContentBackground(.hidden)
                    
                    
                    // share button
                    Button(action: {
                        stringURL = entriesToUrl(sharedData.entries, fee: fees ?? 0, tax: taxes ?? 0, tip: tips ?? 0)
                        UIPasteboard.general.string = stringURL
                        
                    }) {
                       Label("Share", systemImage: "square.and.arrow.up")

                           .padding(20)
                           .foregroundColor(.black)
                           .background(Color(red: 1, green: 189/255, blue: 189/255))
                           .cornerRadius(8)
                   }
                   //.padding(5)
                    
                   
                    
                    
                } // v stack
                .frame(maxHeight: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                )
            }
            .onAppear {
                if sharedData.fee != 0 {
                    fees = sharedData.fee
                }
                if sharedData.tax != 0 {
                    taxes = sharedData.tax
                }
                if sharedData.tip != 0 {
                    tips = sharedData.tip
                }
            }
    }
}
// access camera
struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

// preview the selected image
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}



struct AddBillView_Previews: PreviewProvider {
    static var previews: some View {
        AddBillView()
    }
}
