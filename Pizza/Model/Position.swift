//
//  Position.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import Foundation

struct Position {
    var id: String
    var product: Product
    var count: Int
    var cost: Int {
        return product.price * self.count
    }
}
