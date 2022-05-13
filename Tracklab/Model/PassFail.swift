//
//  PassFail.swift
//  Tracklab
//
//  Created by Aneta Cadova on 28.04.2022.
//

import Foundation
import RealmSwift

public class PassFail: Evaluation {
    @Persisted var passFailMin: Double

    static func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(PassFail.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
