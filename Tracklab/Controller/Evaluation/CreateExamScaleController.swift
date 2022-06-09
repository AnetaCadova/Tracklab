//
//  CreateEvaluationController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 09.06.2022.
//

import Foundation
import RealmSwift
import UIKit

class CreateExamScaleController: UIViewController {
    var subjectId: Int?
   
    
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet var maxPoinsTextField: UITextField!
    
    @IBOutlet var lowestETextField: UITextField!
    @IBOutlet var lowestDTextField: UITextField!
    @IBOutlet var lowesCTextField: UITextField!
    @IBOutlet var lowestBTextField: UITextField!
    @IBOutlet var lowestATextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    func load() {
        let realm=try! Realm()

        let subject=realm.object(ofType: Subject.self, forPrimaryKey: subjectId)
    }

    @IBAction func createExam(_ sender: Any) {
        if checkExamInput() {
            let realm=try! Realm()
            let subject=realm.object(ofType: Subject.self, forPrimaryKey: subjectId)
            let exam=Exam()
            exam.id=Exam.incrementID()
            exam.maxPoints=Double(maxPoinsTextField.text!)!
            exam.lowestA=Double(lowestATextField.text!)!
            exam.lowestB=Double(lowestBTextField.text!)!
            exam.lowestC=Double(lowesCTextField.text!)!
            exam.lowestD=Double(lowestDTextField.text!)!
            exam.lowestE=Double(lowestETextField.text!)!
            
            try! realm.write {
                realm.add(exam)
                subject?.exam=exam
                subject?.goal=goalTextField.text!
            }
            
            performSegue(withIdentifier: "createScaleToList", sender: self)
        }
    }
    
    func checkExamInput() -> Bool {
        return !goalTextField.text!.isEmpty && !maxPoinsTextField.text!.isEmpty && !lowesCTextField.text!.isEmpty && !lowestBTextField.text!.isEmpty && !lowestATextField.text!.isEmpty && !lowestDTextField.text!.isEmpty && !lowestETextField.text!.isEmpty
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let realm=try! Realm()

                let subject=realm.object(ofType: Subject.self, forPrimaryKey: subjectId)
        if segue.destination is DetailSemesterController {
            let viewController=segue.destination as? DetailSemesterController
            viewController?.semesterId=subject?.semester?.id
        }
    }
}
