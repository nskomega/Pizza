//
//  OrderStatus.swift
//  Pizza
//
//  Created by Mikhail Danilov on 15.07.2022.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    case new = "Новый"
    case cooking = "Готовится"
    case delivery = "Доставляется"
    case complete = "Выполнен"
    case cancelled = "Отменен"
}
