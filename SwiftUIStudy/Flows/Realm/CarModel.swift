//
//  CarModel.swift
//  SwiftUIStudy
//
//  Created by USER on 13.02.2024.
//

import Foundation
import RealmSwift

final class Car: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
}

