//
//  MainTabBarView.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI

struct MainTabBarView: View {

    @StateObject var viewModel: MainTabBarViewModel

    var body: some View {

        TabView {
            NavigationView {
                CatalogScreen()
            }
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("Каталог")
                    }
                }
            CartScreen(viewModel: CartViewModel.shared)
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        Text("Корзина")
                    }
                }
            ProfileScreen(viewModel: ProfileViewModel(profile: CurrentUser(id: "", name: "", phoneNumber: 0000000000, address: "")))
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Профиль")
                    }
                }
        }
    }
}
