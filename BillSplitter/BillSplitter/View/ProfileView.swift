//
//  ProfileView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @State var viewModel = ProfileViewModel()
    @State var name = ""
    @State var email = ""
    
    var body: some View {
        
        NavigationView {
            VStack{
                Text("Profile View!")
                    .padding(50)
                    .font(.largeTitle)
                    .frame(alignment: .top)
                
                //Avatar
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                    .frame(width: 125, height:125)
                
                //Info
                VStack(alignment: .leading, content: {
                    HStack {
                        Text("Name: \(viewModel.name)")
                            .font(.title2)
                            .padding(.top, 25)
                    }
                    HStack {
                        Text("Email: \(viewModel.email)")
                            .font(.title2)
                            .padding(.top, 15)
                    }
                    
                    HStack {
                        NavigationLink("Logout", destination: LoginView())
                            .font(.title2)
                            .padding(.top, 15)
                    }
                })
            }
        }
            
            
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
