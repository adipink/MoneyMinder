//
//  UserManager.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser: Codable{
    let userId: String
    let name: String
    let email: String
    let joined: TimeInterval
}
