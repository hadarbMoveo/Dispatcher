//
//  FavoriteFirestoreRepository.swift
//  Dispatcher
//
//  Created by Hadar Basson on 04/09/2023.
//

import Foundation
import FirebaseFirestore

class FavoriteFirestoreRepository: FavoriteRepositoryProtocol {
    let db = Firestore.firestore()

    func addNewUser() async {
        do {
            let ref = try await db.collection("articles").addDocument(data: [
                "first": "Ada",
                "last": "Lovelace",
                "born": 1815
            ])
            print("Document added with ID: \(ref.documentID)")
        } catch {
            print("Error adding document: \(error)")
        }
    }


     func getDocuments() async {
        do {
            let querySnapshot = try await db.collection("articles").getDocuments()
            for document in querySnapshot.documents {
                print("\(document.documentID) => \(document.data())")
            }
        } catch {
            print("Error getting documents: \(error)")
        }
    }
}
