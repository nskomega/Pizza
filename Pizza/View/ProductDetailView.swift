//
//  ProductDetailView.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI

struct ProductDetailView: View {

    @StateObject var viewModel: ProductDateilViewModel
    @State var size = "Маленькая"
    @State var count = 1

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Image(uiImage: self.viewModel.image!)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 360)
                HStack {
                    Text("\(viewModel.product.title)")
                        .font(.title2.bold())
                    Spacer()
                    Text("\(viewModel.getPrice(size: self.size)) ₽")
                        .font(.title2.bold())
                }.padding(.horizontal)
                Text("\(viewModel.product.description)")
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                HStack {
                    Stepper("Количество", value: $count, in: 1...10)
                    Text("\(self.count)")
                        .padding(.leading, 32)
                }
                    .padding(.horizontal)
                Picker("Размер пиццы", selection: $size) {
                    ForEach(viewModel.sizes, id: \.self) { item in
                        Text(item)
                    }

                }.pickerStyle(.segmented)
                    .padding()
            }
            Button {
                var position = Position(id: UUID().uuidString, product: viewModel.product, count: self.count)
                position.product.price = viewModel.getPrice(size: self.size)
                CartViewModel.shared.addPosition(position)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Добавить в корзину!")
                    .padding()
                    .padding(.horizontal, 60)
                    .background(LinearGradient(colors: [Color("orange"), Color("yellow")], startPoint: .trailing, endPoint: .leading))
                    .foregroundColor(.black)
                    .cornerRadius(30)
                    .shadow(radius: 5)
            }
            .onAppear {
                self.viewModel.getImage()
            }
            Spacer()
        }.ignoresSafeArea()
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDateilViewModel(product: Product(
            id: "1",
            title: "Маргарита Гурмэ",
            imageUrl: "not found",
            price: 450,
            description: "Самая вкусная пицца")))
    }
}
