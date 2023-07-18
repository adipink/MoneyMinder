//
//  RootViewModel.swift
//  ExpenseTrack
//
//  Created by אוראל חדד on 17/07/2023.
//

import Foundation
import FirebaseAuth

class RootViewModel: ObservableObject {
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
