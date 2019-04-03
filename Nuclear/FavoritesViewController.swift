//
//  FavoritesViewController.swift
//  Nuclear
//
//  Created by Tung CHENG on 2019/4/2.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit
import NDBKit

private let reuseIdentifier = "Group"

class FavoritesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(.group, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FoodGroup.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FoodGroupTableCell
        let group = FoodGroup.allCases[indexPath.row]
        cell.configure(for: group)
        return cell
    }
}
