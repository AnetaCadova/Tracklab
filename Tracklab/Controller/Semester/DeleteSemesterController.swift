//
//  DeleteSemesterController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 12.05.2022.
//

import Foundation
import RealmSwift
import UIKit

class DeleteSemesterController: UIViewController {
    var semesterId: Int?

    @IBOutlet var deleteLabel: UILabel!

    override func viewDidLoad() {
        load()
        super.viewDidLoad()
    }

    func load() {
        let realm = try! Realm()

        let semester = realm.object(ofType: Semester.self, forPrimaryKey: semesterId)
        deleteLabel.text = "Are you sure you want to delete " + (semester?.name ?? "the semester") + " ?"
    }

    @IBAction func deleteSemester(_ sender: Any) {
        let realm = try! Realm()
        let semester = realm.object(ofType: Semester.self, forPrimaryKey: semesterId)
        try! realm.write {
            realm.delete(semester!)
        }
        performSegue(withIdentifier: "deleteToList", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailSemesterController {
            let viewController = segue.destination as? DetailSemesterController
            viewController?.semesterId = semesterId
        }
    }
}
