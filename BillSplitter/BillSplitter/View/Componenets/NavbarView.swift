//
//  NavbarView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import SwiftUI
import Foundation

struct NavbarView: View {
    @State private var selection = 0
        
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                
                FriendsView()
                    .tabItem {
                        Image(systemName: "person.2")
                        Text("Friends")
                    }
                    .tag(1)
                
                GroupsView()
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("Groups")
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .tag(3)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                // Handle action for a button in the navigation bar
            }) {
                Image(systemName: "plus")
            })
        }
    }
}

struct NavbarView_Previews: PreviewProvider {
   static var previews: some View {
       NavbarView()
    }
}

