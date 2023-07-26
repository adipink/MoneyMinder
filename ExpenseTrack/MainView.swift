//
//  ContentView.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import SwiftUI
import Firebase
import FirebaseAuth

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
            TabView{
                
                ExpenseView(userId: viewModel.currentUserId)
                    .tabItem{
                        Label("Home", systemImage: "house")
                    }
                 
                ProfileView()
                    .tabItem{
                        Label("Profile", systemImage: "person.circle")
                    }
            }
        }else{
            SigninEmailView()
        }
            
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
