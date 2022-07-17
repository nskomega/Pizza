//
//  AdminOrdersScreen.swift
//  Pizza
//
//  Created by Mikhail Danilov on 16.07.2022.
//

import SwiftUI

struct AdminOrdersScreen: View {

    @StateObject var viewModel = AdminOrdersViewModel()
    @State var isOrderViewShow = false

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button {
                    AuthtorizationService.shared.signOut()
                    self.isOrderViewShow.toggle()
                } label: {
                    Text("Выход")
                        .foregroundColor(.white)
                        .background(Color.red)
                }
                Spacer()
                Button {
                    print("Добавить товар")
                } label: {
                    Text("Добавить товар")
                        .foregroundColor(.white)
                        .background(Color.green)
                }

                Spacer()
                Button {
                    self.viewModel.getOrders()
                } label: {
                    Text("Обновить")
                        .foregroundColor(.white)
                        .background(Color.blue)
                }

            }
            List {
                ForEach(viewModel.orders, id: \.id) { order in
                    OrderCell(order: order)
                        .onTapGesture {
                            self.viewModel.currentOrder = order
                            self.isOrderViewShow.toggle()
                        }
                }

            }.listStyle(.plain)
                .onAppear {
                    viewModel.getOrders()
                }
                .sheet(isPresented: $isOrderViewShow) {
                    let orderViewModel = AdminDetailOrderViewModel(order: viewModel.currentOrder)
                    AdminDetailOrderScreen(viewModel: orderViewModel)
                }
        }.fullScreenCover(isPresented: $isOrderViewShow) {
            AuthorizationScreen()
        }
    }
}

struct AdminOrdersScreen_Previews: PreviewProvider {
    static var previews: some View {
        AdminOrdersScreen()
    }
}
