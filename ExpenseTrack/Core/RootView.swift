//
//  RootView.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import SwiftUI

struct RootView: View {
    
    @StateObject var viewModel = RootViewModel()
    
    //@State private var showSignInView: Bool = false
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
            //signedIn
            NavigationStack{
                HomeView()
            }
            
        }else{
            NavigationStack{
                AuthenticationView()
            }
        }
        /*
        ZStack{
            NavigationStack{
                ProfileView(showSignInView: $showSignInView)
            }
        }
        .onAppear{
            let authUser =
            try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
         */
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
