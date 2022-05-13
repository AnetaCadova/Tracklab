//
//  DetailSubjectController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 13.05.2022.
//

import Foundation
import RealmSwift
import UIKit

class DetailSubjectController: UIViewController {
    var subjectId: Int?

    @IBOutlet var subjectNameLabel: UINavigationItem!
    @IBOutlet var numberOfCreditsLabel: UITextField!

    @IBOutlet var codeLabel: UITextField!
    @IBOutlet var goalLabel: UITextField!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        load()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func load() {
        tableView.delegate = self
        tableView.dataSource = self
        let realm = try! Realm()

        let subject = realm.object(ofType: Subject.self, forPrimaryKey: subjectId)
        let credits = String(subject!.credits)
        subjectNameLabel.title = subject?.name
        numberOfCreditsLabel.text = credits
        goalLabel.text = subject?.goal
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let realm = try! Realm()

        let subject = realm.object(ofType: Subject.self, forPrimaryKey: subjectId)
        if segue.destination is DeleteSubjectController {
            let viewController = segue.destination as? DeleteSubjectController
            viewController?.subjectId = subjectId
            viewController?.semesterId = subject!.semester!.id
        }
        if segue.destination is CreateTaskController {
            let viewController = segue.destination as? CreateTaskController
            viewController?.subjectId = subjectId
        }
    }
}

extension DetailSubjectController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "taskDetail") as! DetailTaskController
        let taskCell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell

        vc.taskId = taskCell.taskId
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DetailSubjectController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        return realm.objects(Task.self).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let realm = try! Realm()

        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        cell.taskNameLabel.font = UIFont(name: "SF Pro", size: 12)

        let tasks = Array(realm.objects(Task.self))
        cell.taskNameLabel.text = tasks[indexPath.row].name
        cell.taskId = tasks[indexPath.row].id

        return cell
    }
}

class TaskTableViewCell: UITableViewCell {
    var taskId: Int?

    @IBOutlet var taskNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
