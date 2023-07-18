//
//  MainViewModel.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import Foundation
import FirebaseAuth

class MainViewModel: ObservableObject{
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener{
            [weak self] _, user in DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool{
        return Auth.auth().currentUser != nil
    }
}
