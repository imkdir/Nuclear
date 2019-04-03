//
//  SearchViewController.swift
//  Nuclear
//
//  Created by Tung CHENG on 2019/4/3.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

private let headerReuseIdentifier = "SearchHeader"

public struct NutrientUI {
    public static var tintColor: UIColor = #colorLiteral(red: 1, green: 0.1771841645, blue: 0.3328129351, alpha: 1)
}

final public class SearchViewController: UITableViewController {
    
    private var searchController: UISearchController!
    
    private var resultsViewController: ResultsViewController!
    
    public weak var delegate: NutrientsViewControllerDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        resultsViewController = ResultsViewController()
        resultsViewController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
//        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Food Name"
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .yes
        searchController.searchBar.tintColor = NutrientUI.tintColor
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.sectionHeaderHeight = 60
        tableView.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(SearchHeaderView.self, forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
    
        definesPresentationContext = true
        
        if navigationController?.presentingViewController != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissIfPresented))
            navigationController?.navigationBar.tintColor = NutrientUI.tintColor
        }
    }
    
    private func search(with searchTerm: String) {
        resultsViewController.searchTerm = searchTerm
    
        NutrientAPI.search(with: searchTerm, completion: { result in
            DispatchQueue.main.async {
                if case .success(let results) = result {
                    self.resultsViewController.results = results
                    self.resultsViewController.tableView.reloadData()
                } else {
                    // FIXME: handle failure case
                }
            }
        })
    }
    
    @objc
    private func clearSearch() {
        SearchHistory.clear()
        tableView.reloadData()
    }
    
    @objc
    private func dismissIfPresented() {
        dismiss(animated: true)
    }
}

extension SearchViewController {
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView === self.tableView {
            let term = SearchHistory.read[indexPath.row]
            searchController.isActive = true
            searchController.searchBar.text = term
            search(with: term)
        } else {
            let food = resultsViewController.results[indexPath.row]
            NutrientAPI.report(for: food.ndbno, completion: { result in
                if case .success(let nutrients) = result {
                    DispatchQueue.main.async {
                        let vc = NutrientsViewController()
                        vc.title = "Nutrition Facts"
                        vc.foodName = food.shortedName
                        vc.delegate = self.delegate
                        vc.nutrients = nutrients.group(by: { $0.group })
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    // FIXME: handle failure case
                }
            })
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension SearchViewController {
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchHistory.read.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel!.text = SearchHistory.read[indexPath.row]
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard tableView === self.tableView else { return nil }
        guard !SearchHistory.read.isEmpty else { return nil }
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier) as! SearchHeaderView
        header.button.addTarget(self, action: #selector(clearSearch), for: [.touchUpInside])
        return header
    }
}

extension SearchViewController: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text!.trimmingCharacters(in: .whitespaces)
        guard !searchTerm.isEmpty else { return }
        
        resultsViewController.results.removeAll()
        resultsViewController.tableView.reloadData()
        
        searchBar.resignFirstResponder()
        search(with: searchTerm)
        SearchHistory.log(term: searchTerm)
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resultsViewController.results.removeAll()
        resultsViewController.tableView.reloadData()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty else { return }
        resultsViewController.results.removeAll()
        resultsViewController.tableView.reloadData()
    }
}

extension SearchViewController: UISearchControllerDelegate {
    
    public func presentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    public func willPresentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    public func didPresentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    public func willDismissSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    public func didDismissSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
        tableView.reloadData()
    }
    
}
