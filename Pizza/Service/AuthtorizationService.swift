//
//  AuthtorizationService.swift
//  Pizza
//
//  Created by Mikhail Danilov on 15.07.2022.
//

import Foundation
import FirebaseAuth

class AuthtorizationService {

    static let shared = AuthtorizationService()

    private init() { }

    private let autorization = Auth.auth()

    private var currentUser: User? {
        return autorization.currentUser
    }

    func registration(email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        autorization.createUser(withEmail: email, password: password) {
            result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
