//
//  PizzaApp.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI

let screen = UIScreen.main.bounds

@main
struct PizzaApp: App {
    var body: some Scene {
        WindowGroup {
            AuthorizationScreen()
        }
    }
}
