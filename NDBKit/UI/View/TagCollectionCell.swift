//
//  TagCollectionCell.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/4/5.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

extension UINib {
    static let tagCell = UINib(nibName: "TagCollectionCell", bundle: Bundle(for: TagCollectionCell.self))
}

final class TagCollectionCell: UICollectionViewCell {
    @IBOutlet weak var labelTag: UILabel!
    
    func configure(for tag: String) {
        labelTag.text = tag
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
