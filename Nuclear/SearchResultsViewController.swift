//
//  SearchResultsViewController.swift
//  Nuclear
//
//  Created by Tung CHENG on 2019/4/2.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit
import NDBKit

private let reuseIdentifier = "Result"

final class SearchResultsViewController: UITableViewController {
    fileprivate let searchBar = UISearchBar()
    
    fileprivate var results: [SearchResult] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate var term: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.frame = CGRect(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: 51))
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Food name, NDB number"
        searchBar.delegate = self
        
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib.searchResult, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchResultTableCell
        cell.configure(for: results[indexPath.row], term: term)
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableView.endEditing(true)
    }
}

extension SearchResultsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text?.trimmingCharacters(in: .whitespaces),
            !term.isEmpty else { return }
        self.term = term
        searchBar.resignFirstResponder()
        
        NutrientAPI.search(with: term, completion: { results in
            DispatchQueue.main.async {
                self.results = results
            }
        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        results.removeAll()
    }
}
