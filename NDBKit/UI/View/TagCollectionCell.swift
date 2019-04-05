//
//  TagCollectionCell.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/4/5.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

final class TagCollectionCell: UICollectionViewCell {
    fileprivate let labelTag = UILabel()
    
    func configure(for tag: String) {
        labelTag.text = tag
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        contentView.addSubview(labelTag)
        
        labelTag.textAlignment = .center
        labelTag.font = UIFont.systemFont(ofSize: 40)
        labelTag.translatesAutoresizingMaskIntoConstraints = false
        labelTag.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        labelTag.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard isSelected else { return }
        #colorLiteral(red: 1, green: 0.1771841645, blue: 0.3328129351, alpha: 1).withAlphaComponent(0.2).setFill()
        let margin: CGFloat = 2
        let rect = rect.insetBy(dx: margin, dy: margin)
        let path = UIBezierPath(ovalIn: rect)
        path.fill()
    }

}
