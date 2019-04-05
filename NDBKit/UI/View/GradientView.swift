//
//  GradientView.swift
//  Nuclear
//
//  Created by Tung CHENG on 2019/4/2.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView : IBView {
    
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
