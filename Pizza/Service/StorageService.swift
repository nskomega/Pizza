//
//  StorageService.swift
//  Pizza
//
//  Created by Mikhail Danilov on 17.07.2022.
//

import Foundation
import FirebaseStorage

class StorageService {
    static let shared = StorageService()

    private init() { }

    private let storage = Storage.storage().reference()
    private var productReference: StorageReference {
        self.storage.child("products")
    }

    func upload(id: String, image: Data, comletion: @escaping (Result<String, Error>) -> ()) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        self.productReference.child(id).putData(image, metadata: metadata) { metadata, error in
            guard let metadata = metadata else {
                if let error = error {
                    comletion(.failure(error))
                }
                return
            }
            comletion(.success("Размер полученного изображения: \(metadata.size)"))
        }
    }
}
