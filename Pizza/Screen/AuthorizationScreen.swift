//
//  ContentView.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI

struct AuthorizationScreen: View {
    @State private var isAuthorization = true
    @State private var isTabBarViewShow = false
    @State private var email = ""
    @State private var password = ""
    @State private var comfirmPassword = ""
    @State private var isShowAlert = false
    @State private var alertMessage = ""


    var body: some View {

        VStack(spacing: 15) {
            Text(isAuthorization ? "Авторизация" : "Регистрация")
                .padding(isAuthorization ? 12 : 20)
                .padding(.horizontal, 30)
                .font(.title2.bold())
                .background(Color("alphaWhite"))
                .cornerRadius(isAuthorization ? 30 : 60)
            VStack {
                TextField("Введите Email", text: $email)
                    .padding()
                    .background(Color("alphaWhite"))
                    .cornerRadius(12)
                    .padding(10)
                    .padding(.horizontal, 12)

                SecureField("Введите пароль", text: $password)
                    .padding()
                    .background(Color("alphaWhite"))
                    .cornerRadius(12)
                    .padding(10)
                    .padding(.horizontal, 12)

                if !isAuthorization {
                    SecureField("Введите пароль", text: $comfirmPassword)
                        .padding()
                        .background(Color("alphaWhite"))
                        .cornerRadius(12)
                        .padding(10)
                        .padding(.horizontal, 12)
                }

                Button {
                    if isAuthorization {
                        print("Авторизация")
                        isTabBarViewShow.toggle()
                    } else {
                        print("Регистация пользователя")
                        guard password == self.comfirmPassword else {
                            self.alertMessage = "Пароли не совпадают!"
                            self.isShowAlert.toggle()
                            return
                        }
                        AuthtorizationService.shared.registration(
                            email: self.email,
                            password: self.password,
                            completion: { result in
                                switch result {
                                case .success(let user):
                                    guard let email = user.email else { return }
                                    self.alertMessage = "Вы зарегистрировались с email \(email)"
                                    self.isShowAlert.toggle()
                                    self.email = ""
                                    self.password = ""
                                    self.comfirmPassword = ""
                                    self.isAuthorization.toggle()
                                case .failure(let error):
                                    self.alertMessage = "Ошибка регистрации \(error.localizedDescription)"
                                    self.isShowAlert.toggle()
                                }

                        })
                    }
                } label: {
                    Text(isAuthorization ? "Войти" : "Создать аккаунт!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color("orange"), Color("yellow")], startPoint: .trailing, endPoint: .leading))
                        .cornerRadius(12)
                        .padding(10)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                }
                Button {
                    self.isAuthorization.toggle()
                } label: {
                    Text(isAuthorization ? "Регистрация" : "Уже есть аккаунт!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .padding(10)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(Color("brown"))
                }
            }
            .padding()
            .background(Color("alphaWhite"))
            .cornerRadius(26)
            .padding(isAuthorization ? 30 : 12)
            .alert(self.alertMessage, isPresented: $isShowAlert) {
                Button {

                } label: {
                    Text("Хорошо")
                }

            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("background")
                .ignoresSafeArea()
                .blur(radius: isAuthorization ? 0 : 6)
                        )
            .animation(Animation.easeInOut(duration: 0.4), value: isAuthorization)
            .fullScreenCover(isPresented: $isTabBarViewShow) {
                MainTabBarView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationScreen()
    }
}
