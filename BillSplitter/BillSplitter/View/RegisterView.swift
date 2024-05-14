//
//  RegisterView.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import Foundation
import SwiftUI


struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @State var email = ""
    @State var password = ""
    @State var rePassword = ""
    
    var body: some View {
        //NavigationView {
            VStack {
                Text("Bill Splitter")
                    .font(.largeTitle)
                    .foregroundColor(.cyan)
                    .padding(.top, 25)
                
                
                Text("Register")
                    .font(.largeTitle)
                    .padding(.top, 5)
                
                
                Form {
                    if !viewModel.error.isEmpty {
                        Text(viewModel.error)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Address", text: $email)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    SecureField("Password", text: $password)
                    SecureField("Reenter Password", text: $rePassword)
                    
                    Button {
                       
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                            Text("Register")
                                .bold()
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding (15)
                }
                
                
                Spacer()
                
                VStack {
                    Text("Returning User?")
                        .padding(.top, 25)
                   
                    NavigationLink("Login", destination: LoginView())
                        .navigationBarBackButtonHidden()
                        .padding(.bottom, 25)
                    
                }
            }
        //}
            
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
    
