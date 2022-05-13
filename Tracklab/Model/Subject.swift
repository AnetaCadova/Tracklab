//
//  Subject.swift
//  Tracklab
//
//  Created by Aneta Cadova on 28.04.2022.
//

import Foundation
import RealmSwift

public class Subject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var code: String
    @Persisted var credits: Int
    @Persisted var exam: Exam?
    @Persisted var passFail: PassFail?
    @Persisted var goal: String
    @Persisted var currentPoints: Double
    @Persisted var semester: Semester?
    @Persisted var user: User?

    static func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Subject.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
