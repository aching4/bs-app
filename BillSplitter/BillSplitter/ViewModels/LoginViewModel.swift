//
//  LoginViewModel.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import Foundation
//import fsatAPI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var error = ""
    
    init() {
    }
    func login() {
        guard validate() else {
            return
        }
        
        //Try log in 
        
    }
    private func validate() -> Bool {
        error = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            error = "Please fill in all fields."
            
            return false
        }
        
        //email@example.com
        guard email.contains("@") && email.contains(".") else {
            error = "Please enter valid email."
            
            return false
        }
        
        return true
    }
        
    
}
