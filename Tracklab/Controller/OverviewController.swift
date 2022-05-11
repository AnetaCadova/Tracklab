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
    
    var semesterId :Int?
    var taskId:Int?

    override func viewDidLoad() {
        load()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func load() {
        let realm = try! Realm()
      
        let semester = Semester()
        semester.id=Semester.incrementID()
        semester.name = "Spring 2021"
                
        let task = Task()
        task.id = Task.incrementID()
        task.maxPoints = 10
        task.name = "C# - HW02"
        task.currentPoints = 0
        task.dueDate = Date.now
        
        try! realm.write {
            realm.add(semester)
            realm.add(task)
        }
        
        let semester2 = Semester()
        semester2.id=Semester.incrementID()
        semester2.name = "Spring 2022"
        
        try! realm.write {
            realm.add(semester2)
        }

        currentSemesterButton.setTitle(semester.name, for: .normal)
        semesterId = semester.id
        upcomingTaskButton.setTitle(task.name, for: .normal)
        taskId=task.id
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailSemesterController {
            let viewController = segue.destination as? DetailSemesterController
            viewController?.semesterId = semesterId
        }
    }
}
