//
//  NewSemesterController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 29.04.2022.
//

import Foundation
import RealmSwift
import UIKit

class CreateSemesterController: UIViewController {
    @IBOutlet var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createSemester(_ sender: Any) {
        if !nameTextField.text!.isEmpty {
            let realm = try! Realm()
          
            let semester = Semester()
            semester.id = Semester.incrementID()
            semester.name = nameTextField.text!
            
            try! realm.write {
                realm.add(semester)
            }
            performSegue(withIdentifier: "createToListSemester", sender: self)
        }
    }
}
