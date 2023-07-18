//
//  SignupEmailViewModel.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class SignupEmailViewmodel: ObservableObject{
    
    @Published var name = "" 
    @Published var email = ""
    @Published var password = ""
    
    init(){}
    
    
    func signUp(){
        guard validate() else{
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            self?.insertUser(id: userId)
        }
    }
    private func insertUser(id: String){
        let newUser = DBUser(userId: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let database = Firestore.firestore()
        database.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
        
    }
    
    private func validate() ->Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            return false
        }
        
        guard password.count >= 6 else {
            return false
        }
        
        return true
    }
}
