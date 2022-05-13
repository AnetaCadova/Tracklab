//
//  DeleteTaskController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 13.05.2022.
//

import Foundation
import RealmSwift
import UIKit

class DeleteTaskController: UIViewController {
    var taskId: Int?
    var subjectId:Int?

    @IBOutlet var deleteTaskLabel: UILabel!
    override func viewDidLoad() {
        load()
        super.viewDidLoad()
    }

    func load() {
        let realm = try! Realm()

        let task = realm.object(ofType: Task.self, forPrimaryKey: taskId)
        deleteTaskLabel.text = "Delete " + (task?.name ?? "the semester") + " ?"
    }

    @IBAction func deleteTask(_ sender: Any) {
        let realm = try! Realm()
        let task = realm.object(ofType: Task.self, forPrimaryKey: taskId)
        try! realm.write {
            realm.delete(task!)
        }
        performSegue(withIdentifier: "deleteTaskToSubjectDetail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailTaskController {
            let viewController = segue.destination as? DetailTaskController
            viewController?.taskId = taskId
        }
        if segue.destination is DetailSubjectController {
            let viewController = segue.destination as? DetailSubjectController
            viewController?.subjectId = subjectId
        }
    }
}
