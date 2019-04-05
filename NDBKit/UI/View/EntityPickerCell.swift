//
//  EntityPickerCell.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/4/4.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

final class EntityPickerCell: UIView {
    fileprivate let textLabel = UILabel()
    
    var title: String? {
        set {
            textLabel.text = newValue
        }
        get {
            return textLabel.text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        
        textLabel.font = .systemFont(ofSize: 16, weight: .medium)
        textLabel.textColor = UIColor(white: 0, alpha: 0.75)
        textLabel.textAlignment = .center
        textLabel.sizeToFit()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
