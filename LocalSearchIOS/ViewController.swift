//
//  ViewController.swift
//  LocalSearchIOS
//
//  Created by Gatuk Chattanon on 18/5/21.
//

import UIKit

var allFruits: [Fruits]?

class ViewController: UIViewController {
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var startTime: Date?
    var endTime: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadAllFruits()
        tableView.reloadData()
    }

    func loadAllFruits() {
        startTime = Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate)
        let store = FruitsStore(dbManager: DbManager.shared)
        allFruits = store.getAll()
        endTime = Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate)
        print(startTime, endTime)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFruits?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "fruitCell")
        cell.textLabel?.text = allFruits?[indexPath.row].name

        return cell
    }
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
