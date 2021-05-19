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
    @IBOutlet weak var searchText: UITextField!
    let store = FruitsStore(dbManager: DbManager.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        allFruits = store.getAll()
        tableView.reloadData()
    }

    @IBAction func onSearchChanged(_ sender: Any) {
        guard let text = searchText.text else { return }
        allFruits = store.search(text: text)
        tableView.reloadData()
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
