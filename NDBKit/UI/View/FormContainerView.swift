//
//  FormContainerView.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/4/4.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

@IBDesignable
final class FormContainerView: UIView {
    
    @IBInspectable
    var maskedCorners: UInt {
        set {
            layer.maskedCorners = CACornerMask(rawValue: newValue)
        }
        get {
            return layer.maskedCorners.rawValue
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: .init(width: 12, height: 12)).cgPath
    }
}
