//
//  DatabaseService.swift
//  Pizza
//
//  Created by Mikhail Danilov on 15.07.2022.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    static let shared = DatabaseService()

    private let db = Firestore.firestore()

    private var usersReference: CollectionReference {
        return db.collection("users")
    }

    private var orderReference: CollectionReference {
        return db.collection("orders")
    }

    private init() { }

    func setProfile(user: CurrentUser, completion: @escaping (Result<CurrentUser, Error>) -> ()) {
        self.usersReference.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }

    func getProfile(completion: @escaping (Result<CurrentUser, Error>) -> ()) {
        guard let user = AuthtorizationService.shared.currentUser else { return }
        self.usersReference.document(user.uid).getDocument { dogSnapshot, error in
            guard let snapshot = dogSnapshot else { return }
            guard let data = snapshot.data() else { return }
            guard let userName = data["name"] as? String else { return }
            guard let id = data["id"] as? String else { return }
            guard let phoneNumber = data["phoneNumber"] as? Int else { return }
            guard let address = data["address"] as? String else { return }
            let user = CurrentUser(id: id, name: userName, phoneNumber: phoneNumber, address: address)
            completion(.success(user))
        }
    }

    func setOrder(order: Order, completion: @escaping (Result<Order, Error>) -> ()) {
        self.orderReference.document(order.id).setData(order.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.setPositions(to: order.id, positions: order.positions) { result in
                    switch result {
                    case .success(let positions):
                        print(positions.count)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                completion(.success(order))
            }
        }
    }

    func setPositions(to orderId: String, positions: [Position], completion: @escaping (Result<[Position], Error>) -> ()) {
        let positionReference = orderReference.document(orderId).collection("positions")
        for position in positions {
            positionReference.document(position.id).setData(position.representation)
            completion(.success(positions))
        }
    }
}
