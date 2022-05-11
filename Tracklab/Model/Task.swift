//
//  Task.swift
//  Tracklab
//
//  Created by Aneta Cadova on 28.04.2022.
//

import Foundation
import RealmSwift

public class Task:Object{
    @Persisted (primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var maxPoints: Int
    @Persisted var evaluationId: Int
    @Persisted var goal: Double
    @Persisted var currentPoints: Double
    @Persisted var dueDate:Date
    @Persisted var subject: Subject?
    @Persisted var user: User?
    
    static func incrementID() -> Int {
       let realm = try! Realm()
       return (realm.objects(Task.self).max(ofProperty: "id") as Int? ?? 0) + 1
   }
    
    
}
