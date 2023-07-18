//
//  TransactionCardView.swift
//  ExpenseTracker
//
//  Created by Kristina & Adi
//

import SwiftUI

struct TransactionCardView: View {
    var expense: Expense
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    
    var body: some View {
        let formattedDate = formatDate(expense.date)
        HStack(spacing: 12) {
            //MARK: First Letter Avatar
            if let first = expense.remark.first {
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(Color(expense.color))
                            .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
                    )
            }
            
            Text(expense.remark)
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .trailing, spacing: 7) {
                //MARK: Displaying Price
                let price = expenseViewModel.convertingNumberToPrice(value: expense.type == .expense ? -expense.amount : expense.amount)
                Text(price)
                    .font(.callout)
                    .opacity(0.7)
                    .foregroundColor(expense.type == .expense ? Color("Red") : Color("Green"))
               
                Text(formattedDate)
                                    .font(.caption)
                                    .opacity(0.5)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
        )
    }
}

private func formatDate(_ timestamp: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        let expense = Expense(id: "1", remark: "Sample Expense", amount: 10.0, date: Date().timeIntervalSince1970, type: .expense, color: "Green")
        TransactionCardView(expense: expense)
                    .environmentObject(ExpenseViewModel())
    }
    
    
}
