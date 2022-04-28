//
//  Semester.swift
//  Tracklab
//
//  Created by Aneta Cadova on 28.04.2022.
//

import Foundation
import RealmSwift

public class Semester: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var user: User?
    @Persisted var numberOfCredits: Int

    static func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Semester.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
