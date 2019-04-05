//
//  FormEntityButton.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/4/4.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let entityTextFieldDidBeginEditing = Notification.Name(rawValue: "entityTextFieldDidBeginEditing")
}

@IBDesignable
class FormEntityView: UIView {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable
    var color: UIColor {
        set {
            _color = newValue
        }
        get {
            return _color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
    
    override func draw(_ rect: CGRect) {
        let top = rect.inset(by: .init(top: 0, left: 0, bottom: 30, right: 0))
        var path = UIBezierPath(rect: top)
        headColor.setFill()
        path.fill()
        let bottom = rect.inset(by: .init(top: 15, left: 0, bottom: 0, right: 0))
        path = UIBezierPath(rect: bottom)
        bodyColor.setFill()
        path.fill()
    }
    
    @objc
    private func handleTap(_ g: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
    
    private var _color: UIColor = .clear {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var headColor: UIColor {
        #if DEBUG
        return color
        #else
        return textField.isFirstResponder
            ? color : UIColor(white: 0, alpha: 0.2)
        #endif
    }
    
    private var bodyColor: UIColor {
        #if DEBUG
        return UIColor(white: 1, alpha: 0.4)
        #else
        let alpha: CGFloat = textField.isFirstResponder ? 0.6 : 0.4
        return UIColor(white: 1, alpha: alpha)
        #endif
    }
}

extension FormEntityView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setNeedsDisplay()
        UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }).startAnimation()
        NotificationCenter.default.post(name: .entityTextFieldDidBeginEditing, object: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setNeedsDisplay()
        UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
            self.transform = .identity
        }).startAnimation()
    }
}
