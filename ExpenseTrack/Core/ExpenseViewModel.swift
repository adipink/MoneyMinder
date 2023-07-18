//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Kristina & Adi
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth



class ExpenseViewModel: ObservableObject {
    @Published var starDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    
    //MARK: Expense/ Income Tab
    @Published var tabName: ExpenseType = .expense
    
    @Published var addNewExpense: Bool = false
    @Published var amount: String = ""
    @Published var type: ExpenseType = .all
    @Published var date: Date = Date()
    @Published var remark: String = ""
    
    //MARK: Filter View
    @Published var showFilterView: Bool = false
    
    @Published var expenses: [Expense] = []
    
    init(){
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month], from: Date())
        
        starDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
    }
    func fetchExpenses() {
        //Get the current user
        guard let userId = Auth.auth().currentUser?.uid else{
            return
        }
        
        let expensesCollection = Firestore.firestore()
                    .collection("users")
                    .document(userId)
                    .collection("expenses")
            
        expensesCollection.getDocuments { [weak self] querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching expenses: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let expenses = try documents.compactMap { try $0.data(as: Expense.self) }
                DispatchQueue.main.async { [weak self] in
                    self?.expenses = expenses
                }
            } catch {
                print("Error decoding expenses: \(error.localizedDescription)")
            }
            print(self?.expenses as Any)
        }

       
        }
    
    func currentMonthDateStarting()->String{
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func convertingdDateToString()->String{
        return starDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    
    func convertingNumberToPrice(value: Double)->String{
        let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "₪"
            
            return formatter.string(from: NSNumber(value: value)) ?? "₪0.00"
    }
    
    func convertExpensesToCurrency(expenses: [Expense], type: ExpenseType = .all)->String{
        var value: Double = 0
        value = expenses.reduce(0, { partialResult, expense in
            return partialResult + (type == .all ? (expense.type == .income ? expense.amount: -expense.amount) : (expense.type == type ? expense.amount : 0))
        })
        return convertingNumberToPrice(value: value)
    }
    
    //MARK: Clearing All Data
    func clearData(){
        date = Date()
        type = .all
        remark = ""
        amount = ""
    }
    
    
    //MARK: Save Data
    func saveData(env: EnvironmentValues){
        //Get the current user
        guard let userId = Auth.auth().currentUser?.uid else{
            return
        }
        
        //Create model
        let newId = UUID().uuidString
        let amountINDouble = (amount as NSString).doubleValue
        let colors = ["Dark green", "Beige", "Khaki", "Yellow", "Brown"]
        let color = colors.randomElement() ?? "Yellow"
        
        let newExpense = Expense(
            id: newId,
            remark: remark,
            amount: amountINDouble,
            date: date.timeIntervalSince1970,
            type: type,
            color: color)
        
        
        //Save model
        let database = Firestore.firestore()
        database.collection("users")
            .document(userId)
            .collection("expenses")
            .document(newId)
            .setData(newExpense.asDictionary())
        
        env.dismiss()
    }
}
