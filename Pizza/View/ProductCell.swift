//
//  ProductCell.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI

struct ProductCell: View {

    var product: Product
    @State var uiImage = UIImage(named: "pizza")

    var body: some View {
        VStack(spacing: 2) {
            Image(uiImage: uiImage!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: screen.width * 0.45)
                .clipped()
            HStack {
                Text(product.title)
                    .font(.custom("AvenirNext-regular", size: 15))
                Spacer()
                Text("\(product.price) ₽")
                    .font(.custom("AvenirNext-bold", size: 12))
            }
            .padding(.horizontal, 6)
            .padding(.bottom, 6)
        }.frame(width: screen.width * 0.45, height: screen.width * 0.55)
            .background(.white)
            .cornerRadius(18)
            .shadow(radius: 6)
            .onAppear {
                StorageService.shared.downloadProductImage(id: self.product.id) { result in
                    switch result {
                    case .success(let data):
                        if let img = UIImage(data: data) {
                            self.uiImage = img
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product(
            id: "1",
            title: "Маргарита Гурмэ",
            imageUrl: "not found",
            price: 450,
            description: "Самая вкусная пицца")
        )
    }
}
