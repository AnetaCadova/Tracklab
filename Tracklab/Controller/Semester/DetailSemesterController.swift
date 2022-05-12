//
//  GetSemesterController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 29.04.2022.
//

import Foundation
import RealmSwift
import UIKit

class DetailSemesterController: UIViewController {
    var semesterId: Int?

    @IBOutlet var numberOfCreditsLabel: UITextField!
    @IBOutlet var semesterName: UINavigationItem!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        load()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func load() {
        let realm = try! Realm()

        let semester = realm.object(ofType: Semester.self, forPrimaryKey: semesterId)
        let credits = String(semester!.numberOfCredits)
        semesterName.title = semester?.name
        numberOfCreditsLabel.text = credits
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DeleteSemesterController {
            let viewController = segue.destination as? DeleteSemesterController
            viewController?.semesterId = semesterId
        }
    }
}
