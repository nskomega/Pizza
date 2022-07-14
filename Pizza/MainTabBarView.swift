//
//  MainTabBarView.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI

struct MainTabBarView: View {
    var body: some View {

        TabView {
            Text("Каталог")
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("Каталог")
                    }
                }
            Text("Корзина")
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        Text("Корзина")
                    }
                }
            Text("Профиль")
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Профиль")
                    }
                }
        }
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}
