//
//  ContentView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//  Code by Suzanna L on 5/12/24

import SwiftUI
import BillDashboardView
import AddBillView

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                //Active Splits
                List {
                    Section(header: Text("Active")) {
                        ForEach(1..<3) { index in
                            Text("Active \(index)")
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                
                //Past You Owned Splits
                List {
                    Section(header: Text("Created By You")) {
                        ForEach(1..<3) { index in
                            Text("Past \(index)")
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                
                //Past Other Owned Splits
                List {
                    Section(header: Text("Created By Others")) {
                        ForEach(1..<3) { index in
                            Text("Past \(index)")
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                
                //button to add bill
                Spacer()
                NavigationLink(destination: AddBillView()) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
