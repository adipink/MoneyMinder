//
//  TransactionManager.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Expense: Codable, Identifiable {
    let id: String
    let remark: String
    let amount: Double
    let date: TimeInterval
    let type: ExpenseType
    let color: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case remark
        case amount
        case date
        case type
        case color
    }
}

enum ExpenseType: String, Codable {
    case income = "Income"
    case expense = "Expenses"
    case all = "ALL"
}
