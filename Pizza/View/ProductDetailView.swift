//
//  ProductDetailView.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI

struct ProductDetailView: View {

    var product: Product

    var body: some View {
        Text("\(product.title)")
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(
            id: "1",
            title: "Маргарита Гурмэ",
            imageUrl: "not found",
            price: 450,
            description: "Самая вкусная пицца")
        )
    }
}
