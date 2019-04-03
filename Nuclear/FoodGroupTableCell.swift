//
//  FoodGroupTableCell.swift
//  Nuclear
//
//  Created by Tung CHENG on 2019/4/2.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit
import NDBKit

extension UINib {
    static let group = UINib(nibName: "FoodGroupTableCell", bundle: .main)
}

final class FoodGroupTableCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    
    func configure(for group: FoodGroup) {
        labelName.text = group.description
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
