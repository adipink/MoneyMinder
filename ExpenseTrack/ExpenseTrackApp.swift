//
//  ExpenseTrackApp.swift
//  ExpenseTrack
//
//  Created by Kristina & Adi
//

import SwiftUI
import Firebase


@main
struct ExpenseTrackApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
