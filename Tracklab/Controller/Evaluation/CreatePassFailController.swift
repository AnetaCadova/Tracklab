//
//  CreatePassFailController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 09.06.2022.
//

import Foundation
import RealmSwift
import UIKit

class CreatePassFailController: UIViewController {
    var subjectId: Int?
   
    @IBOutlet weak var maxPointsTextField: UITextField!
    
    @IBOutlet weak var passFailMinTextField: UITextField!
    
    @IBOutlet weak var goalTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    func load() {
        let realm=try! Realm()

        let subject=realm.object(ofType: Subject.self, forPrimaryKey: subjectId)
    }

    @IBAction func createPassFail(_ sender: Any) {
        if checkPassFailInput() {
            let realm=try! Realm()
            let subject=realm.object(ofType: Subject.self, forPrimaryKey: subjectId)
            let passFail=PassFail()
            passFail.id=PassFail.incrementID()
            passFail.maxPoints=Double(maxPointsTextField.text!)!
            passFail.passFailMin = Double(passFailMinTextField.text!)!
            
                        try! realm.write {
                realm.add(passFail)
                subject?.passFail=passFail
                subject?.goal=goalTextField.text!
            }
            
            performSegue(withIdentifier: "createPassFailScaleToList", sender: self)
        }
    }
       
    func checkPassFailInput() -> Bool {
        return !goalTextField.text!.isEmpty && !maxPointsTextField.text!.isEmpty && !passFailMinTextField.text!.isEmpty
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
