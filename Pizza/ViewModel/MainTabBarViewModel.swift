//
//  MainTabbarViewModel.swift
//  Pizza
//
//  Created by Mikhail Danilov on 15.07.2022.
//

import Foundation
import FirebaseAuth

class MainTabBarViewModel: ObservableObject {
    @Published var user: User

    init(user: User) {
        self.user = user
    }
}
