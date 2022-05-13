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

    @IBOutlet weak var semesterName: UINavigationItem!
    @IBOutlet weak var numberOfCreditsLabel: UITextField!
    @IBOutlet  var tableView: UITableView!
    override func viewDidLoad() {
        load()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func load() {
        tableView.delegate = self
        tableView.dataSource = self
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
        if segue.destination is CreateSubjectController {
            let viewController = segue.destination as? CreateSubjectController
            viewController?.semesterId = semesterId
        }
    }
    

}

extension DetailSemesterController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "subjectDetail") as! DetailSubjectController
        let subjectCell  = tableView.cellForRow(at: indexPath) as! SubjectTableViewCell
        
        vc.subjectId = subjectCell.sujectId
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DetailSemesterController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        return realm.objects(Subject.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let realm = try! Realm()

        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath) as! SubjectTableViewCell
        cell.subjectNameLabel.font = UIFont(name: "SF Pro", size: 12)

        let subjects = Array(realm.objects(Subject.self))
        cell.subjectNameLabel.text = subjects[indexPath.row].name
        cell.sujectId = subjects[indexPath.row].id
        
        return cell
    }
}

class SubjectTableViewCell: UITableViewCell {
    var sujectId: Int?
   
    @IBOutlet weak var subjectNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

