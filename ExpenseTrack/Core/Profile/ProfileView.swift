//
//  ProfileView.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    var body: some View {
        NavigationView{
            VStack{
                if let user = viewModel.user{
                    profile(user: user)
                } else{
                    Text("Loading Profile")
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear(){
            viewModel.loadCurrentUser()
        }
    }
    
    @ViewBuilder
    func profile(user: DBUser) -> some View{
        //INFO: name, email, member since
        VStack(alignment: .leading){
            HStack{
                Text("Name: ")
                    .bold()
                Text(user.name)
            }.padding()
            
            HStack{
                Text("Email: ")
                    .bold()
                Text(user.email)
            }.padding()
            
            HStack{
                Text("Member Since: ")
                    .bold()
                Text(Date(timeIntervalSince1970: user.joined).formatted(date: .long, time: .omitted)) 
                
            }.padding()
            
        }
        //SignOut
        Button (action: {viewModel.signout()}){
            Text("Sign out")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.vertical,15)
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(
                            LinearGradient(colors: [
                                Color("Gradient1"),
                                Color("Gradient2"),
                                Color("Gradient3"),], startPoint: .topLeading, endPoint: .bottomTrailing))
                }.foregroundColor(.white)
                .padding(.bottom, 10)
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
            ProfileView()
    }
}
