//
//  Login.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import Foundation
import SwiftUI


struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        //NavigationView {
            VStack {
                
                Text("Bill Splitter")
                    .font(.largeTitle)
                    .foregroundColor(.cyan)
                    .padding(.top, 25)
                
                Text("Login")
                    .font(.largeTitle)
                    .padding(.top, 5)
                
                Spacer()
                
                Form {
                    
                    if !viewModel.error.isEmpty {
                        Text(viewModel.error)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    SecureField("Password", text: $viewModel.password)
                    
                    Button {
                        viewModel.login()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                            Text("Login")
                                .bold()
                                .foregroundColor(Color.white)
                        }
                        .padding (15)
                    }
                        
                }
                Spacer()
                
                VStack {
                    Text("New?")
                        .padding(.top, 25)
                    
                    NavigationLink("Create Account", destination: RegisterView())
                        .navigationBarBackButtonHidden()
                        .padding(.bottom, 25)
                        
                }
            }
            
        //}
    }
}
    
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

        
