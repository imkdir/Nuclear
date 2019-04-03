//
//  GradientView.swift
//  Nuclear
//
//  Created by Tung CHENG on 2019/4/2.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView : UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    private var gradientColors: [CGColor] = [] {
        didSet {
            if gradientColors.count == 2 {
                (layer as! CAGradientLayer).colors = gradientColors
            }
        }
    }
    
    private var locations: [NSNumber] = [] {
        didSet {
            if locations.count == 2 {
                (layer as! CAGradientLayer).locations = locations
            }
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    @IBInspectable var startColor: UIColor = .clear {
        didSet {
            gradientColors.insert(startColor.cgColor, at: 0)
        }
    }
    
    @IBInspectable var endColor: UIColor = .clear {
        didSet {
            gradientColors.insert(endColor.cgColor, at: 1)
        }
    }
    
    @IBInspectable var location0: Float = 0 {
        didSet {
            locations.insert(.init(value: location0), at: 0)
        }
    }
    
    @IBInspectable var location1: Float = 0 {
        didSet {
            locations.insert(.init(value: location1), at: 1)
        }
    }
    
    @IBInspectable var startPoint: CGPoint = .init(x: 0.5, y: 1) {
        didSet {
            (layer as! CAGradientLayer).startPoint = startPoint
        }
    }
    
    @IBInspectable var endPoint: CGPoint = .init(x: 0.5, y: 1) {
        didSet {
            (layer as! CAGradientLayer).endPoint = endPoint
        }
    }
}
