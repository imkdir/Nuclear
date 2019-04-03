//
//  NutrientTableCell.swift
//  Nuclear
//
//  Created by Tung CHENG on 2019/4/2.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

extension UINib {
    static let nutrient = UINib(nibName: "NutrientTableCell", bundle: Bundle(for: NutrientTableCell.self))
}

extension Nutrient {
    var attributedDescription: NSAttributedString {
        let mutable = NSMutableAttributedString(string: value)
        mutable.append(.init(
            string: " " + unit,
            attributes: [
                .font: UIFont.systemFont(ofSize: 15)]))
        return mutable
    }
}

class NutrientTableCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    
    func configure(for nutrient: Nutrient) {
        labelName.text = nutrient.name
        labelValue.attributedText = nutrient.attributedDescription
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
