//
//  GroupsView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//  Code by Suzanna L on 5/12/24

import SwiftUI
import Foundation

struct GroupsView: View {
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 5)) // Minimum item width of 5
    ]
    
    //code reference from rohit-13.medium.com
    var body: some View {
        ScrollView {
            LazyVGrid(columns: self.columns) {
                ForEach(groups, id: \.self) { item in
                    Text("\(item)")
                        .frame(width: 30, height: 30)
                        .background(Color.orange)
                        .foregroundColor(Color.black)
                        .cornerRadius(25)
                }
            }
        }
        .padding()
        
        //button to add groups
        Spacer()
        NavigationLink(destination: AddGroupView()) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
        }
        .padding(.trailing, 20)
        .padding(.bottom, 20)
    }
}
