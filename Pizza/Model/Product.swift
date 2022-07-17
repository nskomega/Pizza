//
//  Product.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import Foundation

struct Product {
    var id: String
    var title: String
    var imageUrl: String = ""
    var price: Int
    var description: String
//    var ordersCount: Int
//    var isRecommend: Bool

    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["title"] = self.title
        repres["price"] = self.price
        repres["description"] = self.description
        return repres
    }
}
