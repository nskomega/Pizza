//
//  PizzaApp.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI
import Firebase

let screen = UIScreen.main.bounds

@main
struct PizzaApp: App {

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            if let user = AuthtorizationService.shared.currentUser {
                if user.uid == "BnQ2vLTEIkasBu08p1U3EHtaCAU2" {
                    AdminOrdersScreen()
                } else {
                    let viewModel = MainTabBarViewModel(user: user)
                    MainTabBarView(viewModel: viewModel)
                }
            } else {
                AuthorizationScreen()
            }
        }
    }

    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }

    }
}
