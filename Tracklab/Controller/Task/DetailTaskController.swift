//
//  DetailTaskController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 13.05.2022.
//

import Foundation
import RealmSwift
import UIKit

class DetailTaskController: UIViewController {
    var taskId: Int?
    
    @IBOutlet var dueDateLabel: UITextField!
    @IBOutlet var taskNameLabel: UINavigationItem!
    @IBOutlet var currentPointsLabel: UITextField!
    @IBOutlet var goalLabel: UITextField!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var goalProgressBar: UIProgressView!
    @IBOutlet var maxPointsLabel: UITextField!
    @IBOutlet var saveButon: UIButton!

    override func viewDidLoad() {
        load()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func load() {
        let realm=try! Realm()

        let task=realm.object(ofType: Task.self, forPrimaryKey: taskId)
        taskNameLabel.title=task?.name
        dueDateLabel.text=task?.dueDate.formatted()
        currentPointsLabel.text=String(task!.currentPoints)
        goalLabel.text=String(task!.goal)
        maxPointsLabel.text=String(task!.maxPoints)
        setProgressBar(task: task!)
        goalProgressBar.progress=Float(task!.goal/task!.maxPoints)
        saveButon.isEnabled=false
        saveButon.isHidden=true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let realm=try! Realm()

        let task=realm.object(ofType: Task.self, forPrimaryKey: taskId)
        if segue.destination is DeleteTaskController {
            let viewController=segue.destination as? DeleteTaskController
            viewController?.taskId=taskId
            viewController?.subjectId=task!.subject!.id
        }
    }

    @IBAction func editTask(_ sender: Any) {
        enableTextFields()
        saveButon.isEnabled=true
        saveButon.isHidden=false
    }

    @IBAction func saveChanges(_ sender: Any) {
        let realm=try! Realm()
        let task=realm.object(ofType: Task.self, forPrimaryKey: taskId)

        try! realm.write {
            task?.currentPoints=Double(currentPointsLabel.text!)!
            task?.maxPoints=Double(maxPointsLabel.text!)!
            task?.goal=Double(goalLabel.text!)!
            task?.subject?.currentPoints=task!.subject!.currentPoints+task!.currentPoints
            setProgressBar(task: task!)
        }
        lockTextFields()
        saveButon.isEnabled=false
        saveButon.isHidden=true
    }

    func lockTextFields() {
        currentPointsLabel.isEnabled=false
        dueDateLabel.isEnabled=false
        goalLabel.isEnabled=false
        maxPointsLabel.isEnabled=false
    }

    func enableTextFields() {
        currentPointsLabel.isEnabled=true
        goalLabel.isEnabled=true
        maxPointsLabel.isEnabled=true
    }

    func setProgressBar(task: Task) {
        if task.currentPoints == 0 {
            progressBar.progress=0
        } else {
            progressBar.progress=Float(task.currentPoints/task.maxPoints)
        }
    }
}
