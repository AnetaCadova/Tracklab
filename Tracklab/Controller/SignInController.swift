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
        let realm = try! Realm()

        if realm.objects(User.self).count == 0 {
            let user = User()
            user.id = User.incrementID()
            user.firstName = "first name"
            user.lastName = "last name"
            user.email = "user@gmail.com"
            user.password = "password"

            try! realm.write {
                realm.add(user)
            }
        }

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signIn(_ sender: Any) {
        if checkCredentials() {
            performSegue(withIdentifier: "signInToOverView", sender: self)
        }
    }

    func checkCredentials() -> Bool {
        if (emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty) {
            return false
        }
        let realm = try! Realm()

        let users = realm.objects(User.self)
        let usersWithEmail = users.where {
            $0.email == emailTextField.text!
        }

        if users.isEmpty {
            return false
        }

        return (usersWithEmail.first?.password == passwordTextField.text)
    }
}
