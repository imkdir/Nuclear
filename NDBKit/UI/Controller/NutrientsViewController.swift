//
//  NutrientsViewController.swift
//  Nuclear
//
//  Created by Tung CHENG on 2019/4/2.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Nutrient"

final public class NutrientsViewController: UITableViewController {
    
    public var foodName: String?
    internal var nutrients: [String: [Nutrient]] = [:]
    
    public weak var delegate: NutrientsViewControllerDelegate?
    
    fileprivate var groups: [Nutrient.Group] {
        return Nutrient.Group.allCases
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationController?.navigationBar.tintColor = NutrientUI.tintColor

        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.sectionHeaderHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(.nutrient, forCellReuseIdentifier: reuseIdentifier)
    }
    
    @objc
    private func doneButtonTapped() {
        defer {
            navigationController?.dismiss(animated: true)
        }
        let key = Nutrient.Group.proximate.rawValue
        guard let group = nutrients[key] else { return }
        delegate?.nutrient(controller: self, send: group.dictionary)
    }

    // MARK: - Table view data source

    override public func numberOfSections(in tableView: UITableView) -> Int {
        return groups.count
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = groups[section].rawValue
        return nutrients[key, default: []].count
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! NutrientTableCell
        let key = groups[indexPath.section].rawValue
        let nutrient = nutrients[key]![indexPath.row]
        cell.configure(for: nutrient)
        return cell
    }

    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groups[section].rawValue
    }

    override public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard section == groups.count - 1 else { return nil }
        return "All nutrients' value are expressed in 100g."
    }
}

extension String {
    static var energy: String { return "208" }
    static var protein: String { return "203" }
    static var totalFat: String { return "204" }
    static var carbohydrate: String { return "205" }
}

extension Array where Element == Nutrient {
    var dictionary: [String: String] {
        var dict: [String: String] = [:]
        for each in self {
            dict[each.nutrientId] = each.value
        }
        return dict
    }
}

public extension Collection {
    
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        return categories
    }
}
