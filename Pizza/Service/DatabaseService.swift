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

    private init() { }

    func createUser(user: CurrentUser, completion: @escaping (Result<CurrentUser, Error>) -> ()) {
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
}
