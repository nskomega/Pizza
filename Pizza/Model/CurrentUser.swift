//
//  CurrentUser.swift
//  Pizza
//
//  Created by Mikhail Danilov on 15.07.2022.
//

import Foundation

struct CurrentUser: Identifiable {
    var id: String
    var name: String
    var phoneNumber: Int
    var address: String

    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phoneNumber"] = self.phoneNumber
        repres["address"] = self.address
        return repres
    }
}
