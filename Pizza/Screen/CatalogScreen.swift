//
//  CatalogScreen.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI

struct CatalogScreen: View {

    let layout = [GridItem(.adaptive(minimum: screen.width / 2.4))]

    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            Section("Рекомендации") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layout, spacing: 12) {
                        ForEach(CatalogViewModel.shared.topProducts, id: \.id) { item in
                            NavigationLink {
                                let viewModel = ProductDateilViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }.padding()
                }
            }
            Section("Пицца") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layout) {
                        ForEach(CatalogViewModel.shared.topProducts, id: \.id) { item in
                            NavigationLink {
                                let viewModel = ProductDateilViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }.padding()
                }
            }
        }.navigationTitle("Каталог")
    }
}

struct CatalogScreen_Previews: PreviewProvider {
    static var previews: some View {
        CatalogScreen()
    }
}
