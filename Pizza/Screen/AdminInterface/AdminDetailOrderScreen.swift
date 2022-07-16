//
//  AdminDetailOrderScreen.swift
//  Pizza
//
//  Created by Mikhail Danilov on 16.07.2022.
//

import SwiftUI

struct AdminDetailOrderScreen: View {

    @StateObject var viewModel: AdminDetailOrderViewModel

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {
            Text("\(viewModel.user.name)")
                .font(.title3).bold()
            Text("\(viewModel.user.phoneNumber)")
                .bold()
            Text("\(viewModel.user.address)")
            List {
                ForEach(viewModel.order.positions, id: \.id) { position in
                    PositionCell(position: position)
                }
                Text("Итого: \(viewModel.order.cost) ₽")
                    .bold()
            }
        }.padding()
            .onAppear {
                viewModel.getUserDate()
            }
    }
}

struct AdminDetailOrderScreen_Previews: PreviewProvider {
    static var previews: some View {
        AdminDetailOrderScreen(viewModel: AdminDetailOrderViewModel(order: Order(userID: "", date: Date(), status: "Новый")))
    }
}
