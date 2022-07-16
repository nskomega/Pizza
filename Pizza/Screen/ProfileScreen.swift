//
//  ProfileScreen.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI

struct ProfileScreen: View {

    @State var isAvatarAlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthorizationViewPresented = false

    @StateObject var viewModel: ProfileViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 18) {
                Image("human")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(8)
                    .background(Color.orange)
                    .clipShape(Circle())
                    .onTapGesture {
                        self.isAvatarAlertPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять фотку", isPresented: $isAvatarAlertPresented) {
                        Button {
                            print("Выбираем из галереи")
                        } label: {
                            Text("Из галереи")
                        }
                        Button {
                            print("Камера")
                        } label: {
                            Text("С камеры")
                        }
                    }
                VStack(alignment: .leading, spacing: 12) {
                    TextField("Имя", text: $viewModel.profile.name)
                        .font(.body.bold())
                    HStack {
                        Text("+7")
                        TextField("Телефон", value: $viewModel.profile.phoneNumber, format: .number)
                    }
                }
            }
            VStack(alignment: .leading) {
                Text("Адрес доставки:")
                    .bold()
                TextField("Адрес доставки:", text: $viewModel.profile.address)
            }.padding(.horizontal)
            List {
                if viewModel.orders.count == 0 {
                    Text("Ваши заказы будут тут!")
                } else {
                    ForEach(viewModel.orders, id: \.id) { order in
                        OrderCell(order: order)
                    }
                }
            }.listStyle(.plain)
            Button {
                self.isQuitAlertPresented.toggle()
            } label: {
                Text("Выйти")
                    .padding()
                    .padding(.horizontal, 30)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }.padding()
                .confirmationDialog("Вы уверены, что хотите выйти?", isPresented: $isQuitAlertPresented) {
                    Button {
                        self.isAuthorizationViewPresented.toggle()

                    } label: {
                        Text("Да")
                    }
                }
                .fullScreenCover(isPresented: $isAuthorizationViewPresented, onDismiss: nil) {
                    AuthorizationScreen()
                }

        }.padding()
            .onSubmit {
                self.viewModel.setProfile()
            }
            .onAppear {
                self.viewModel.getProfile()
                self.viewModel.getOrders()
            }

    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(viewModel: ProfileViewModel(profile: CurrentUser(id: "", name: "Олег Николавич", phoneNumber: 893884274, address: "ул. Ленина д. 1")))
    }
}
