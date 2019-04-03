//
//  ResultsViewController.swift
//  Nuclear
//
//  Created by Tung CHENG on 2019/4/2.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Result"

final class ResultsViewController: UITableViewController {
    
    private var loadingIndicator: UIActivityIndicatorView!
    
    var results: [SearchResult] = [] {
        didSet {
            self.loadingIndicator.stopAnimating()
        }
    }
    var searchTerm: String! {
        didSet {
            self.loadingIndicator.startAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.sectionHeaderHeight = 0
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib.searchResult, forCellReuseIdentifier: reuseIdentifier)
        
        loadingIndicator = UIActivityIndicatorView(style: .gray)
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchResultTableCell
        cell.configure(for: results[indexPath.row], term: searchTerm)
        return cell
    }
}

extension SearchResult {
    var shortedName: String {
        return name.replacingOccurrences(of: String.USDAFoodDistributionProgram, with: "")
    }
}
