//
//  AdminDetailOrderScreen.swift
//  Pizza
//
//  Created by Mikhail Danilov on 16.07.2022.
//

import SwiftUI

struct AdminDetailOrderScreen: View {

    @StateObject var viewModel: AdminDetailOrderViewModel
    var status: [String] {
        var sts = [String]()
        for status in OrderStatus.allCases {
            sts.append(status.rawValue)
        }
        return sts
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {
            Text("\(viewModel.user.name)")
                .font(.title3).bold()
            Text("\(viewModel.user.phoneNumber)")
                .bold()
            Text("\(viewModel.user.address)")
            Picker(selection: $viewModel.order.status) {
                ForEach(self.status, id: \.self) { status in
                    Text(status)
                }
            } label: {
                Text("Статус заказа")
            }.pickerStyle(.segmented)
            .onChange(of: viewModel.order.status) { newStatus in
                DatabaseService.shared.setOrder(order: viewModel.order) { result in
                    switch result {
                    case .success(let order):
                        print(order.status)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            List {
                ForEach(viewModel.order.positions, id: \.id) { position in
                    PositionCell(position: position)
                }
            }.padding()
                .onAppear {
                    viewModel.getUserDate()
                }
            Text("Итого: \(viewModel.order.cost) ₽")
                .bold()
        }
    }
}

struct AdminDetailOrderScreen_Previews: PreviewProvider {
    static var previews: some View {
        AdminDetailOrderScreen(viewModel: AdminDetailOrderViewModel(order: Order(userID: "", date: Date(), status: "Новый")))
    }
}
