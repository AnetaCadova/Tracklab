//
//  DeleteSubjectController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 12.05.2022.
//

import Foundation
import RealmSwift
import SwiftUI
import UIKit

class DeleteSubjectController: UIViewController {
    var subjectId: Int?
    var semesterId: Int?

    @IBOutlet var deleteSubjectLabel: UILabel!
    override func viewDidLoad() {
        load()
        super.viewDidLoad()
    }

    func load() {
        let realm = try! Realm()

        let subject = realm.object(ofType: Subject.self, forPrimaryKey: subjectId)
        deleteSubjectLabel.text = "Are you sure you want to delete " + (subject?.name ?? "the semester") + " ?"
    }

    @IBAction func deleteSubject(_ sender: Any) {
        let realm = try! Realm()
        let subject = realm.object(ofType: Subject.self, forPrimaryKey: subjectId)
        try! realm.write {
            deleteAllTasksFromSubject(subject: subject!)
            realm.delete(subject!)
        }
        performSegue(withIdentifier: "deleteSubjectToSemesterDetail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailSubjectController {
            let viewController = segue.destination as? DetailSubjectController
            viewController?.subjectId = subjectId
        }

        if segue.destination is DetailSemesterController {
            let viewController = segue.destination as? DetailSemesterController
            viewController?.semesterId = semesterId
        }
    }

    func deleteAllTasksFromSubject(subject: Subject) {
        let realm = try! Realm()

        var tasks: [Task] = []
        let taskArr = realm.objects(Task.self)
        for task in taskArr {
            if task.subject == subject {
                tasks.append(task)
            }
        }
        for task in tasks {
            try! realm.write {
                realm.delete(task)
            }
        }
    }
}
