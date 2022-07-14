//
//  CartViewModel.swift
//  Pizza
//
//  Created by Mikhail Danilov on 14.07.2022.
//

import Foundation

class CartViewModel: ObservableObject {
    @Published var positions = [Position]()

    func addPosition(_ position: Position) {
        self.positions.append(position)
    }
}
