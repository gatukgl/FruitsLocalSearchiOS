//
//  MainViewController.swift
//  LocalSearchIOS
//
//  Created by Gatuk Chattanon on 19/5/21.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var theBox: UIView!
    @IBOutlet weak var loadingText: UILabel!
    
    let store = FruitsStore(dbManager: DbManager.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        theBox.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        loadAllFruits()
    }

    func loadAllFruits() {
        loadingText.text = "start..."
        store.save()
        theBox.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        loadingText.text = "loaded"
    }
}
