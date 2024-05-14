//
//  NavbarView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import Foundation
import SwiftUI

struct NavbarView: View {
    @State private var selection = 0
    @State private var isTabEnabled = true
        
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(0)
                
                FriendsView()
                    .tabItem {
                        Image(systemName: "person.2")
                    }
                    .tag(1)
                
                GroupsView()
                    .tabItem {
                        Image(systemName: "person.3")
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                    }
                    .tag(3)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NavbarView_Previews: PreviewProvider {
   static var previews: some View {
       NavbarView()
       
    }
}
