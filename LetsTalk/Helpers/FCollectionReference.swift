//
//  CollectionReference.swift
//  LetsTalk
//
//  Created by Aaron on 2019-08-27.
//  Copyright © 2019 Aaron Wong. All rights reserved.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Typing
    case Recent
    case Message
    case Group
    case Call
}


func reference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}

