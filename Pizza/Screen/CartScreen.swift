//
//  CartScreen.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI

struct CartScreen: View {

    @StateObject var viewModel: CartViewModel

    var body: some View {
        VStack {
            List(viewModel.positions) { position in
                PositionCell(position: position)
                    .swipeActions(content: {
                        Button {
                            viewModel.positions.removeAll { pos in
                                pos.id == position.id
                            }
                        } label: {
                            Text("Удалить")
                        }.tint(.red)
                    })
            }
            .listStyle(.plain)
            .navigationTitle("Корзина")

            HStack {
                Text("ИТОГО:")
                    .fontWeight(.bold)
                Spacer()
                Text("\(self.viewModel.cost) ₽")
                    .fontWeight(.bold)
            }.padding()

            HStack(spacing: 24) {
                Button {
                    print("Отменить")
                } label: {
                    Text("Отменить")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(24)
                }
                Button {
                    print("Заказать")
                } label: {
                    Text("Заказать")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(24)
                }
            }.padding()
        }
    }
}

struct CartScreen_Previews: PreviewProvider {
    static var previews: some View {
        CartScreen(viewModel: CartViewModel.shared)
    }
}
