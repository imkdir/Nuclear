//
//  InventoryTableCell.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/4/5.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

extension UINib {
    public static let inventory = UINib(nibName: "InventoryTableCell", bundle: Bundle(for: InventoryTableCell.self))
}

public struct FoodInfo {
    public let name: String
    public let tag: String
    public let size: String
    public let energy: String
    public let fat: String
    public let protein: String
    public let carbs: String
    
    public init(name: String, tag: String, size: String, energy: String, fat: String, protein: String, carbs: String) {
        self.name = name
        self.tag = tag
        self.size = size
        self.energy = energy
        self.fat = fat
        self.protein = protein
        self.carbs = carbs
    }
}

public class InventoryTableCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTag: UILabel!
    @IBOutlet weak var labelSize: UILabel!
    @IBOutlet weak var labelEnergy: UILabel!
    @IBOutlet weak var labelFat: UILabel!
    @IBOutlet weak var labelProtein: UILabel!
    @IBOutlet weak var labelCarbs: UILabel!
    
    public func configure(for info: FoodInfo) {
        labelName.text = info.name
        labelTag.text = info.tag
        labelSize.text = info.size
        labelEnergy.text = info.energy
        labelFat.text = info.fat
        labelProtein.text = info.protein
        labelCarbs.text = info.carbs
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
