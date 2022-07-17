//
//  ProductDetailViewModel.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import Foundation
import UIKit

class ProductDateilViewModel: ObservableObject {

    @Published var product: Product
    @Published var sizes = ["Маленькая", "Среднаяя", "Большая"]
    @Published var count = 0
    @Published var image = UIImage(named: "pizza")

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

    func getImage() {
        StorageService.shared.downloadProductImage(id: product.id) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
