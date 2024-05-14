//
//  RegisterViewModel.swift
//  BillSplitter
//
//  Created by Ashley C on 5/11/24.
//

import Foundation
class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var rePassword = ""
    @Published var error = ""
    
    init() {
    }
    func register() {
        guard validate() else {
            return
        }
        
        //Try register
        
    }
    
    private func inserUserRecord(id: String) {
        // let newUser =
    }
    
    private func validate() -> Bool {
        error = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty, !rePassword.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            error = "Please fill in all fields."
            
            return false
        }
        
        //email@example.com
        guard email.contains("@") && email.contains(".") else {
            error = "Please enter valid email."
            
            return false
        }
        
        guard password.count >= 6 else{
            error = "Password must be 6 characters or longer"
            
            return false
        }
        
        guard password.lowercased() == rePassword.lowercased() else {
            error = "Passwords do not match."
            
            return false
        }
        
        return true
    }
    
}
