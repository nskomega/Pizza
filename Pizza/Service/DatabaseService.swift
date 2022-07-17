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

    private var productsReference: CollectionReference {
        return db.collection("products")
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

    func getProfile(by userId: String? = nil, completion: @escaping (Result<CurrentUser, Error>) -> ()) {
        self.usersReference.document(userId != nil ? userId! : AuthtorizationService.shared.currentUser!.uid).getDocument { dogSnapshot, error in
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

    func getOrders(by userID: String?, completion: @escaping (Result<[Order], Error>) -> ()) {
        self.orderReference.getDocuments { qsnapshot, error in
            if let qsnapshot = qsnapshot {
                var orders = [Order]()
                for doc in qsnapshot.documents {
                    if let userID = userID {
                        if let order = Order(doc: doc), order.userID == userID {
                            orders.append(order)
                        }
                    } else { //Admin
                        if let order = Order(doc: doc) {
                            orders.append(order)
                        }
                    }
                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    func getPositions(by orderID: String, completion: @escaping (Result<[Position], Error>) -> ()) {
        let positionsReference = orderReference.document(orderID).collection("positions")
        positionsReference.getDocuments { qSnap, error in
            if let querySnaphot = qSnap {
                var positions = [Position]()
                for doc in querySnaphot.documents {
                    if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    func setProduct(product: Product, image: Data, completion: @escaping (Result<Product, Error>) -> ()) {
        StorageService.shared.upload(id: product.id, image: image) { result in
            switch result {
            case .success(let sizeInfo):
                print(sizeInfo)
                self.productsReference.document(product.id).setData(product.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(product))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getProducts(completion: @escaping (Result<[Product], Error>) -> ()) {
        self.productsReference.getDocuments { qSnap, error in
            guard let qSnap = qSnap else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            let docs = qSnap.documents
            var products = [Product]()
            for doc in docs {
                guard let product = Product(doc: doc) else { return }
                products.append(product)
            }
            completion(.success(products))
        }
    }
}
