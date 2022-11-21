//
//  ViewController.swift
//  RecommendCreditCard
//
//  Created by Walter J on 2022/11/21.
//

import UIKit

class MainVC: UITableViewController {    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView에 Cell 등록
        self.setUpTableViewCell()
    }

    private func setUpTableViewCell() {
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: Keys.CellIds.cardListCell)
    }
}

