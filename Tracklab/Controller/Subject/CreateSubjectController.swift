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
    var subjectId: Int?

   
   
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var creditsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func AddExam(_ sender: Any) {
        createSubject()
        performSegue(withIdentifier: "createSubjectToExamScale", sender: self)

    }
    @IBAction func addPassFail(_ sender: Any) {
        createSubject()
        performSegue(withIdentifier: "createSubjectToPassFailScale", sender: self)
        
    }
    
    
    func createSubject() {
        if checkSubjectInput()  {
            let realm = try! Realm()
           
            let semester = realm.object(ofType: Semester.self, forPrimaryKey: semesterId)

//            let exam = Exam()
//            exam.id = Exam.incrementID()
//            exam.name="testEval"
//            exam.maxPoints=100
//            exam.lowestA=90
//            exam.lowestB=80
//            exam.lowestC=70
//            exam.lowestD=60
//            exam.lowestE=50

            let subject = Subject()
            subject.id = Subject.incrementID()
            subject.name = nameTextField.text!
            subject.currentPoints=0
            subject.credits=Int(creditsTextField.text!)!
            subject.code=codeTextField.text!
//            subject.goal=goalTextField.text!
//            subject.exam=exam
            subject.semester = semester
            
            subjectId = subject.id
            
            try! realm.write {
                realm.add(subject)
                semester!.numberOfCredits=semester!.numberOfCredits+subject.credits
            }
            
        }
    }
  
    func checkSubjectInput() ->  Bool{
        return !nameTextField.text!.isEmpty && !codeTextField.text!.isEmpty && !creditsTextField.text!.isEmpty
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CreateExamScaleController {
            let viewController = segue.destination as? CreateExamScaleController
            viewController?.subjectId = subjectId
        }
        
        if segue.destination is CreatePassFailController {
            let viewController = segue.destination as? CreatePassFailController
            viewController?.subjectId = subjectId
        }
    }
}
