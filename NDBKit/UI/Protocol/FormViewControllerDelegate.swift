//
//  FormViewControllerDelegate.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/4/5.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

public protocol FormViewControllerDelegate: class {
    func handleForm(foodName: String?, report stats: (Entity) -> NSNumber)
}
