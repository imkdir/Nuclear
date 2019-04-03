//
//  SearchHeaderView.swift
//  Nuclear
//
//  Created by Tung CHENG on 2019/4/3.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

final class SearchHeaderView: UITableViewHeaderFooterView {
    let label = UILabel()
    let button = UIButton()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        addSubview(button)
        
        label.text = "Recent"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("Clear", for: [.normal])
        button.setTitleColor(NutrientUI.tintColor, for: [.normal])
        button.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        bottomAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 1).isActive = true
        
        trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 15).isActive = true
        button.firstBaselineAnchor.constraint(equalTo: label.firstBaselineAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
