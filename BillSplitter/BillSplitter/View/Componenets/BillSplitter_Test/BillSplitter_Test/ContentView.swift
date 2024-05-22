//
//  ContentView.swift
//  BillSplitter_Test
//
//
//

import SwiftUI


struct ContentView: View {
    @StateObject private var sharedData = SharedData()
    
    @State private var totalPeople: Int?
    @State private var personNameAdded: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text("Bill Splitter")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                        .foregroundColor(.white)
                    
                    Form {
                        Section(header: Text("People").bold().font(.title2)) {
                            TextField("Amount of People", value: $totalPeople, format: .number)
                                .keyboardType(.numberPad)
                                .onChange(of: totalPeople) {
                                    sharedData.peopleNames.removeAll()
                                    if let tp = totalPeople, tp != 0 {
                                        for _ in 1...tp {
                                            sharedData.peopleNames.append("")
                                        }
                                    }
                                }
                        } //section end
                        if sharedData.peopleNames.count != 0 {
                            //if let count = totalPeople {
                            Section(header: Text("Names").font(.title2).bold()){
                                
                                ForEach(0...sharedData.peopleNames.count - 1, id: \.self) { index in
                                    TextField("Name \(index+1)", text: $sharedData.peopleNames[index])
                                } //for each
                            } //section ender
                            //} //if let count
                            
                            
                        } // !totalPeople.isEmpty
                        NavigationLink(destination: AddBillView()) {
                                    Text("Add Bill")
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                            }

                            .padding(20)
                            .cornerRadius(8)
                            .foregroundColor(.black)
                            .background(Color(red: 1, green: 189/255, blue: 189/255))
                            .disabled(sharedData.peopleNames.count == 0 || sharedData.peopleNames.contains{$0 == ""})
                            .foregroundColor(.red)
                            .listRowInsets(EdgeInsets(top: -8, leading: 0, bottom: -8, trailing: 0))
                        
                        
                    } // form
                    .cornerRadius(20)
                    .padding(20)
                    .scrollContentBackground(.hidden)
                    
                    
                } // vstack
                
            } //zstack
        } //nav view
        
        .environmentObject(sharedData)
    } //body

} //contentview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
