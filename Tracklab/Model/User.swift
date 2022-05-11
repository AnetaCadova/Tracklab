//
//  User.swift
//  Tracklab
//
//  Created by Aneta Cadova on 28.04.2022.
//

import Foundation
import RealmSwift

public class User: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var email: String
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var password: String

    static func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(User.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
