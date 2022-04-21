//
//  ViewController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 23.03.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signIn(_ sender: Any) {
        if checkPassword(email: emailTextField.text!) {
            self.performSegue(withIdentifier: "OpenOverview", sender: nil)
        }

        if !checkPassword(email: emailTextField.text!) {
            print("Incorrect passowrd")
        }
    }

    func checkPassword(email: String) -> Bool {
        if let savedUser = UserDefaults.standard.object(forKey: email) as? Data {
            let decoder = JSONDecoder()
            let loadedUser = try? decoder.decode(User.self, from: savedUser)
            return loadedUser?.password == passwordTextField.text!
        }
        return false
    }
}
