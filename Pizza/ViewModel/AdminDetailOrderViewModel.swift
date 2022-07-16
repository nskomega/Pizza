//
//  AdminDetailOrderViewModel.swift
//  Pizza
//
//  Created by Mikhail Danilov on 16.07.2022.
//

import Foundation

class AdminDetailOrderViewModel: ObservableObject {
    @Published var order: Order
    @Published var user = CurrentUser(id: "", name: "", phoneNumber: 0, address: "")

    init(order: Order) {
        self.order = order
    }

    func getUserDate() {
        DatabaseService.shared.getProfile(by: order.userID) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
