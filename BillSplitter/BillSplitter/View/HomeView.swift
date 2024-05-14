//
//  ContentView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                NavigationLink("Register", destination: RegisterView())
            }
            .padding()
            
        }
    }
    
}



#Preview {
    HomeView()
}
