//
//  ProfileViewModel.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth


class ProfileViewModel: ObservableObject{
    init(){}
    
    @Published private(set) var user: DBUser? = nil
    
    
    func loadCurrentUser(){
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let database = Firestore.firestore()
        database.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.user = DBUser(
                    userId: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0)
            }
        }
    }
     
    
    func signout(){
        do{
            try Auth.auth().signOut()
        }catch{
            
        }
        
    }
}
