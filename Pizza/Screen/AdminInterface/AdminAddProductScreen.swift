//
//  AdminAddProductScreen.swift
//  Pizza
//
//  Created by Mikhail Danilov on 17.07.2022.
//

import SwiftUI

struct AdminAddProductScreen: View {
    @State private var isShowImagePicker = false
    @State private var image = UIImage(named: "pizza")!
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var price: Int? = nil

    var body: some View {
        VStack {
            Text("Добавить товар")
                .font(.title2.bold())
            Image(uiImage: image)
                .resizable()
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 320)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(24)
                .onTapGesture {
                    self.isShowImagePicker.toggle()
                }
            TextField("Название продукта", text: $title)
                .padding()
            TextField("Цена продукта", value: $price, format: .number)
                .keyboardType(.numberPad)
                .padding()
            TextField("Описания продукта", text: $description)
                .padding()
            Button {
                print("Сохранить")
            } label: {
                Text("Сохранить")
                    .padding()
                    .padding(.horizontal, 30)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            Spacer()

        }.padding()
        .sheet(isPresented: $isShowImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)

        }
    }
}

struct AdminAddProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        AdminAddProductScreen()
    }
}
