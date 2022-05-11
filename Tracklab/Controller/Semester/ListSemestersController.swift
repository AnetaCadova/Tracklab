//
//  ListSemestersController.swift
//  Tracklab
//
//  Created by Aneta Cadova on 29.04.2022.
//

import Foundation
import RealmSwift
import UIKit

class ListSemestersController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()

        // Do any additional setup after loading the view.
    }
    
    func load() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ListSemestersController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "semesterDetail") as! DetailSemesterController
        let semesterCell  = tableView.cellForRow(at: indexPath) as! SemesterTableViewCell
        
        vc.semesterId = semesterCell.semesterId
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListSemestersController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        return realm.objects(Semester.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let realm = try! Realm()

        let cell = tableView.dequeueReusableCell(withIdentifier: "SemesterCell", for: indexPath) as! SemesterTableViewCell
        cell.semesterNameLabel.font = UIFont(name: "SF Pro", size: 12)

        let semesters = Array(realm.objects(Semester.self))
        cell.semesterNameLabel.text = semesters[indexPath.row].name
        cell.semesterId = semesters[indexPath.row].id
        
        return cell
    }
}

class SemesterTableViewCell: UITableViewCell {
    var semesterId: Int?
    @IBOutlet var semesterNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
