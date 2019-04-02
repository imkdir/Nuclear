//
//  SearchResultTableCell.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/3/31.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

extension UINib {
    public static var searchResult: UINib {
        return UINib(nibName: "SearchResultTableCell", bundle: Bundle(for: SearchResultTableCell.self))
    }
}

open class SearchResultTableCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelGroup: UILabel!
    
    public func configure(for result: SearchResult) {
        labelName.text = result.name
        labelGroup.text = result.group
        
        #if DEBUG
        labelNumber.text = result.ndbno
        #endif
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        #if DEBUG
        labelNumber.isHidden = false
        #endif
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
