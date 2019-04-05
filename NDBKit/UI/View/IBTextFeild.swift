//
//  IBTextFeild.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/4/5.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

@IBDesignable
class IBTextFeild: UITextField {
    
    private var _placeholderColor: UIColor = .clear {
        didSet {
            self.attributedPlaceholder = {
                guard let placeholder = self.placeholder else { return nil }
                return NSAttributedString(string: placeholder, attributes: [.foregroundColor: _placeholderColor])
            }()
        }
    }
    @IBInspectable
    var placeholderColor: UIColor {
        set {
            _placeholderColor = newValue
        }
        get {
            return _placeholderColor
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
