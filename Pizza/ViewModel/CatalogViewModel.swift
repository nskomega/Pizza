//
//  CatalogViewModel.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import Foundation

class CatalogViewModel: ObservableObject {
    static let shared = CatalogViewModel()

    var topProducts = [
        Product(
            id: "1",
            title: "Маргарита Гурмэ",
            imageUrl: "not found",
            price: 450,
            description: "Самая вкусная пицца"),
        Product(
            id: "2",
            title: "Пеперони",
            imageUrl: "not found",
            price: 650,
            description: "Самая вкусная пицца"),
        Product(
            id: "3",
            title: "Гавайская",
            imageUrl: "not found",
            price: 500,
            description: "Самая вкусная пицца"),
        Product(
            id: "4",
            title: "4 сыра",
            imageUrl: "not found",
            price: 600,
            description: "Самая вкусная пицца"),
        Product(
            id: "5",
            title: "Большой папа",
            imageUrl: "not found",
            price: 700,
            description: "Самая вкусная пицца")
        ]

    @Published var pizzas = [
        Product(
            id: "1",
            title: "Маргарита Гурмэ",
            imageUrl: "not found",
            price: 450,
            description: "Самая вкусная пицца"),
        Product(
            id: "2",
            title: "Пеперони",
            imageUrl: "not found",
            price: 650,
            description: "Самая вкусная пицца"),
        Product(
            id: "3",
            title: "Гавайская",
            imageUrl: "not found",
            price: 500,
            description: "Самая вкусная пицца"),
        Product(
            id: "4",
            title: "4 сыра",
            imageUrl: "not found",
            price: 600,
            description: "Самая вкусная пицца"),
        Product(
            id: "5",
            title: "Большой папа",
            imageUrl: "not found",
            price: 700,
            description: "Самая вкусная пицца")
        ]

    func getProducts() {
        DatabaseService.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.pizzas = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
