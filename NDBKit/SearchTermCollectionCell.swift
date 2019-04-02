//
//  SearchTermCollectionCell.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/4/1.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

open class SearchTermCollectionCell: UICollectionViewCell {
    fileprivate let labelTerm = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(labelTerm)
        
        labelTerm.font = UIFont.systemFont(ofSize: 40)
        labelTerm.adjustsFontSizeToFitWidth = true
        labelTerm.textAlignment = .center
        
        labelTerm.translatesAutoresizingMaskIntoConstraints = false
        labelTerm.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        labelTerm.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        labelTerm.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        labelTerm.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
