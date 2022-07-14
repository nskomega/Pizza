//
//  PositionCell.swift
//  Pizza
//
//  Created by Mikhail Danilov on 15.07.2022.
//

import SwiftUI

struct PositionCell: View {

    let position: Position

    var body: some View {
        HStack {
            Text(position.product.title)
                .fontWeight(.bold)
            Spacer()
            Text("\(position.count) шт.")
            Text("\(position.cost) ₽")
                .frame(width: 80, alignment: .trailing)
        }.padding(.horizontal)
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(position: Position(id: UUID().uuidString, product: Product(id: UUID().uuidString, title: "Гавайская", imageUrl: "pizza", price: 350, description: "С ананасом"), count: 3))
    }
}
