//
//  ContentView.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {

        VStack(spacing: 15) {
            Text("Авторизация")
                .padding()
                .padding(.horizontal, 30)
                .font(.title2.bold())
                .background(Color("alphaWhite"))
                .cornerRadius(30)
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

                Button {
                    print("Авторизация")
                } label: {
                    Text("Войти")
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
                    print("Регистрация")
                } label: {
                    Text("Регистрация")
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
            .padding(30)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("background").ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
