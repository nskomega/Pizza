//
//  ProfileViewModel.swift
//  Pizza
//
//  Created by Mikhail Danilov on 15.07.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {

    @Published var profile: CurrentUser
    
    init(profile: CurrentUser) {
        self.profile = profile
    }

    func setProfile() {
        DatabaseService.shared.setProfile(user: self.profile) { result in
            switch result {
            case .success(let user):
                print(user.name)
            case .failure(let error):
                print("Ошибка отправки данных \(error.localizedDescription)")
            }
        }
    }

    func getProfile() {
        DatabaseService.shared.getProfile { result in
            switch result {
            case .success(let user):
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
