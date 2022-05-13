//
//  OverviewController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 29.04.2022.
//

import Foundation
import RealmSwift
import UIKit

class OverviewController: UIViewController {
    @IBOutlet var currentSemesterButton: UIButton!
    @IBOutlet var upcomingTaskButton: UIButton!

    var semesterId: Int?
    var taskId: Int?

    override func viewDidLoad() {
        load()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        load()
    }

    func load() {
        let realm = try! Realm()
        if realm.objects(Semester.self).count == 0 {
            currentSemesterButton.setTitle("Create first semester", for: .normal)

        } else {
            let semester = realm.objects(Semester.self).last
            semesterId = semester!.id
            currentSemesterButton.setTitle(semester!.name, for: .normal)
        }

        if realm.objects(Task.self).count == 0 {
            upcomingTaskButton.isHidden = true
        } else {
            let task = realm.objects(Task.self).last
            taskId = task!.id
            upcomingTaskButton.setTitle(task!.name, for: .normal)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailSemesterController {
            let viewController = segue.destination as? DetailSemesterController
            viewController?.semesterId = semesterId
        }
        if segue.destination is DetailTaskController {
            let viewController = segue.destination as? DetailTaskController
            viewController?.taskId = taskId
        }
    }

    @IBAction func goToSemester(_ sender: Any) {
        if semesterId == nil {
            performSegue(withIdentifier: "overviewToCreate", sender: self)

        } else {
            performSegue(withIdentifier: "overviewToSemesterDetail", sender: self)
        }
    }
}
