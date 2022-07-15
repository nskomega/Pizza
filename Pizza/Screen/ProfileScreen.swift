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
                    Text("Михаил Андреевич Данилов")
                        .bold()
                    Text("+7 (900) 777-77-77")
                }
            }
            VStack(alignment: .leading) {
                Text("Адрес доставки:")
                    .bold()
                Text("Россия, Новосибирская область, г. Новосибирск, ул. Ленина, д.1")
            }
            List {
                Text("Ваши заказы будут тут!")
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
                    .fullScreenCover(isPresented: $isAuthorizationViewPresented, onDismiss: nil) {
                        AuthorizationScreen()
                    }


                }

        }.padding()
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
