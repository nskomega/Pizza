//
//  ProductDetailViewModel.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import Foundation

class ProductDateilViewModel: ObservableObject {

    @Published var product: Product
    @Published var sizes = ["Маленькая", "Среднаяя", "Большая"]
    @Published var count = 0

    init(product: Product) {
        self.product = product
    }

    func getPrice(size: String) -> Int {
        switch size {
        case "Маленькая":
            return product.price
        case "Среднаяя":
            return Int(Double(product.price) * 1.25)
        case "Большая":
            return Int(Double(product.price) * 1.5)
        default: return 0
        }
    }
}
