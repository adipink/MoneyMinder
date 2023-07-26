//
//  ExpenseView.swift
//  ExpenseTrack
//
//   Created by Kristina & Adi
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ExpenseView: View {
    @StateObject var viewmodel: ExpenseViewModel
    private let userId: String

    init(userId: String) {
        self.userId = userId
        _viewmodel = StateObject(wrappedValue: ExpenseViewModel())
        //viewmodel.fetchExpenses()
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 12){
                    HStack(spacing:15){
                        VStack(alignment: .leading, spacing: 4){
                            Text("Welcome")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            
                            Text("MoneyMinder").font(.title2.bold())
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        NavigationLink {
                            FilteredDetailView()
                        } label: {
                            Image(systemName: "hexagon.fill").foregroundColor(.gray).overlay(content: {
                                Circle().stroke(.white, lineWidth: 2).padding(7)
                            })
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                        }
                    }
                    ExpenseCard(expenses: viewmodel.expenses).environmentObject(viewmodel)
                    transactionsView()
                }
                .padding()
            }
            .background {
                Color("BG").ignoresSafeArea()
            }
            .fullScreenCover(isPresented: $viewmodel.addNewExpense){
                viewmodel.clearData()
            }content: {
                NewExpenseView().environmentObject(viewmodel)
            }
            .overlay(alignment: .bottomTrailing) {
                addButton()
            }
            .onAppear {
                viewmodel.fetchExpenses()
            }
        }
        .navigationViewStyle(.stack)
        .environmentObject(viewmodel)
    }
    
    
    //MARK: Transactions View
    @ViewBuilder
    func transactionsView()->some View{
        VStack(spacing: 15){
            Text("Transactions").font(.title2.bold()).opacity(0.7).frame(maxWidth: .infinity,alignment: .leading).padding(.bottom)
            ForEach(viewmodel.expenses) { expense in
                TransactionCardView(expense: expense).environmentObject(viewmodel)
            }
            
        }.padding(.top)
    }
    
    //MARK: Add Button
    @ViewBuilder
    func addButton() -> some View{
        Button{
            viewmodel.addNewExpense.toggle()
        }label: {
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background{
                    Circle().fill(
                        LinearGradient(colors: [
                            Color("Gradient1"),
                            Color("Gradient2"),
                            Color("Gradient3"),], startPoint: .topLeading, endPoint: .bottomTrailing))
                }.shadow(color: .black.opacity(0.1), radius: 5, x:5, y: 5)
        }.padding()
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView(userId: "hNHA8lUvKTOq0z5y3dqaIR9Otts2")
            .environmentObject(ExpenseViewModel())
    }
}
