//
//  CreateTaskController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 13.05.2022.
//

import Foundation
import RealmSwift
import UIKit

class CreateTaskController: UIViewController {
    var subjectId: Int?
   
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var maxPointsTextField: UITextField!
    @IBOutlet var goalTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func createTask(_ sender: Any) {
        if checkTaskInput() {
            let realm = try! Realm()
           
            let subject = realm.object(ofType: Subject.self, forPrimaryKey: subjectId)

            let task = Task()
            task.id = Task.incrementID()
            task.name = nameTextField.text!
            task.goal = Double(goalTextField.text!)!
            task.subject = subject
            task.maxPoints = Double(maxPointsTextField.text!)!
            task.currentPoints = 0
            task.dueDate = datePicker.date
                    
            try! realm.write {
                realm.add(task)
            }
            
            performSegue(withIdentifier: "createTaskToSubjectDetail", sender: self)
        }
    }
  
            
    func checkTaskInput() -> Bool {
        return !nameTextField.text!.isEmpty && !maxPointsTextField.text!.isEmpty && !goalTextField.text!.isEmpty
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailSubjectController {
            let viewController = segue.destination as? DetailSubjectController
            viewController?.subjectId = subjectId
        }
    }
}
