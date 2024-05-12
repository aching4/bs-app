//
//  ContentView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//  Code by Suzanna L on 5/12/24

import SwiftUI

//struct HomeView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing:20){
                NavigationLink(destination: HomeView()) {
                    Text("Home")
                        .foregroundStyle(.teal)
                        .font(.title)
                }
            }
            .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
        }
    }
}



#Preview {
    HomeView()
}
