//
//  FriendsView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//  Code by Suzanna L on 5/12/24

import Foundation
import SwiftUI
import HomeView

struct FriendsView: View {
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 5)) // Minimum item width of 5
    ]
    
    //code reference from rohit-13.medium.com
    var body: some View {
        ScrollView {
            LazyVGrid(friends: self.columns) {
                ForEach(friendProfile, id: \.self) { item in
                    Text("\(item)")
                        .frame(width: 30, height: 30)
                        .background(Color.orange)
                        .foregroundColor(Color.black)
                        .cornerRadius(25)
                }
            }
        }
        .padding()
        
        //button to add friends
        Spacer()
        NavigationLink(destination: HomeView()) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
        }
        .padding(.trailing, 20)
        .padding(.bottom, 20)
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
