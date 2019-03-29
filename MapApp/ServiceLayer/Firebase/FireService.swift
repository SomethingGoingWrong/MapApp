//
//  FireService.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import PromiseKit


protocol FireService {
  func configure()
  func readCities<T: Decodable>(from collectionReference: FirebaseCollectionReference, returning objectType: T.Type) -> Promise<[T]>
  func saveGameTime(from collectionReference: FirebaseCollectionReference, with date: Date, withScore score: Int)
}

class FireServiceImpl : NSObject, FireService {
  
  func configure(){
    FirebaseApp.configure()
  }
  
  private func reference(to collectionReference: FirebaseCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
  }
  
  func readCities<T>(from collectionReference: FirebaseCollectionReference, returning objectType: T.Type) -> Promise<[T]> where T : Decodable {
    let citiesReference = reference(to: .capitalCities)
    return Promise<[T]> { seal -> Void in
      return citiesReference.addSnapshotListener({ (snapshot, error) in
        guard let snapshot = snapshot else { return }
        do {
          var objects = [T]()
          for document in snapshot.documents {
            let object = try document.decode(as: objectType.self)
            objects.append(object)
          }
          seal.fulfill(objects)
        } catch {
          seal.reject(error)
        }
      })
    }
  }
  
  func saveGameTime(from collectionReference: FirebaseCollectionReference, with date: Date, withScore score: Int) {
    let resultsReference = reference(to: .results)
    let dateString = date.toString(dateFormat: "dd.MM.HH:mm")
    let parametrs : [String : Any] = [dateString : "\(score)"]
    resultsReference.addDocument(data: parametrs)
  }
  
}
