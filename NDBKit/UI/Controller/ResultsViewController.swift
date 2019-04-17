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
    
    private let loadingIndicator = UIActivityIndicatorView(style: .gray)
    private let labelNotFound = UILabel()
    
    var results: [SearchResult] = [] {
        didSet {
            tableView.reloadData()
            loadingIndicator.stopAnimating()
            labelNotFound.isHidden = true
        }
    }
    var searchTerm: String! {
        didSet {
            self.loadingIndicator.startAnimating()
        }
    }
    func showError() {
        labelNotFound.isHidden = false
        loadingIndicator.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.sectionHeaderHeight = 0
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib.searchResult, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        view.addSubview(labelNotFound)
        labelNotFound.translatesAutoresizingMaskIntoConstraints = false
        labelNotFound.textColor = UIColor(white: 0, alpha: 0.7)
        labelNotFound.font = .systemFont(ofSize: 15)
        labelNotFound.textAlignment = .center
        labelNotFound.numberOfLines = 0
        labelNotFound.attributedText = attributedNotFound
        labelNotFound.isHidden = true
        
        labelNotFound.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        labelNotFound.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    private lazy var attributedNotFound: NSAttributedString = {
        let mutable = NSMutableAttributedString(attributedString:
            .init(string: "No Results", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium)]))
        mutable.append(.init(string: "\nCheck your network connection and try again."))
        return mutable
    }()
    
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
