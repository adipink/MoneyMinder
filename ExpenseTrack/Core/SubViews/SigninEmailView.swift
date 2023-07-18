//
//  SigninEmailView.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import SwiftUI



struct SigninEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    var body: some View {
        NavigationView{
            VStack{
                //Header
                HeaderView(title: "Login", subtitle: "Take control of your expenses", angle: -15, background: "Gradient1")
                
                Form{
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Enter Email", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    
                    SecureField("Enter Password", text: $viewModel.password)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    
                    Button{
                        viewModel.signIn()
                    } label:{
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color ("Gradient1"))
                            .cornerRadius(10)
                    }
                   }
                VStack{
                    NavigationLink("Create An Account", destination: SignUpEmailView())
                }
                .padding(.bottom, 50)
                Spacer()
                
            }
        }
    }
}

struct SigninEmailView_Previews: PreviewProvider {
    static var previews: some View {
            SigninEmailView()
    }
}
