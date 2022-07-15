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
    var body: some Scene {
        WindowGroup {
            AuthorizationScreen()
        }
    }

    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }

    }
}
