//
//  Order.swift
//  Pizza
//
//  Created by Mikhail Danilov on 15.07.2022.
//

import Foundation
import FirebaseFirestore

struct Order {
    var id: String = UUID().uuidString
    var userID: String
    var positions = [Position]()
    var date: Date
    var status: String

    var cost: Int {
        var sum = 0
        for pos in positions {
            sum += pos.cost
        }
        return sum
    }

    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["userID"] = userID
        repres["date"] = Timestamp(date: date)
        repres["id"] = id
        repres["status"] = status
        return repres
    }
}
