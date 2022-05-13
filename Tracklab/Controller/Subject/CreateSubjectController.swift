//
//  CreateSubjectController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 12.05.2022.
//

import Foundation
import RealmSwift
import UIKit

class CreateSubjectController: UIViewController {
    var semesterId: Int?
   
   
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var creditsTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    
    @IBOutlet weak var ratingScaleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createSubject(_ sender: Any) {
        if checkSubjectInput()  {
            let realm = try! Realm()
           
            let semester = realm.object(ofType: Semester.self, forPrimaryKey: semesterId)

            let exam = Exam()
            exam.id = Exam.incrementID()
            exam.name="testEval"
            exam.maxPoints=100
            exam.lowestA=90
            exam.lowestB=80
            exam.lowestC=70
            exam.lowestD=60
            exam.lowestE=50

            let subject = Subject()
            subject.id = Subject.incrementID()
            subject.name = nameTextField.text!
            subject.currentPoints=0
            subject.credits=Int(creditsTextField.text!)!
            subject.code=codeTextField.text!
            subject.goal=goalTextField.text!
            subject.exam=exam
            subject.semester = semester
            
            try! realm.write {
                realm.add(exam)
                realm.add(subject)
                semester!.numberOfCredits=semester!.numberOfCredits+subject.credits
            }
            
            performSegue(withIdentifier: "createSubjectToList", sender: self)
        }
    }
  
    func checkSubjectInput() ->  Bool{
        return !nameTextField.text!.isEmpty && !codeTextField.text!.isEmpty && !goalTextField.text!.isEmpty
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailSemesterController {
            let viewController = segue.destination as? DetailSemesterController
            viewController?.semesterId = semesterId
        }
    }
}
