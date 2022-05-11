//
//  ViewController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 23.03.2022.
//

import RealmSwift
import UIKit

class SignInController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//    @IBAction func signIn(_ sender: Any) {
//        checkCredentials()
//    }
//
//    func checkCredentials() -> Bool {
//        let realm = try! Realm()
//
//        let users = realm.objects(User.self).filter("email = " + (emailTextField.text ?? ""))
//
//        if users.isEmpty {
//            return false
//        }
//
//        return (users.first?.password == passwordTextField.text)
//    }
}
