//
//  SignUpEmailView.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import SwiftUI

struct SignUpEmailView: View {
    @StateObject private var viewModel = SignupEmailViewmodel()
    var body: some View {
        VStack{
            //Header
            HeaderView(title: "Register", subtitle: "Achieve financial freedom", angle: 15, background: "Gradient2")
            
            
            Form{
                TextField("Enter Name", text: $viewModel.name)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .autocorrectionDisabled()
                TextField("Enter Email", text: $viewModel.email)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                SecureField("Enter Password", text: $viewModel.password)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                
                Button{
                    viewModel.signUp()
                    
                } label:{
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color ("Gradient2"))
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            
        }
        .padding()
    }
}

struct SignUpEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignUpEmailView()
        }
         
    }
}
