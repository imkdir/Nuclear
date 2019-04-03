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

extension String {
    public static let USDAFoodDistributionProgram = "(Includes foods for USDA's Food Distribution Program)"
}

open class SearchResultTableCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelGroup: UILabel!
    @IBOutlet weak var viewFlag: UIView!
    
    public func configure(for result: SearchResult, term: String? = nil) {
        var foodName = result.name
        
        let range = (foodName as NSString).range(of: .USDAFoodDistributionProgram)
        if range.location != NSNotFound {
            foodName = (foodName as NSString).replacingCharacters(in: range, with: "")
            viewFlag.isHidden = false
        } else {
            viewFlag.isHidden = true
        }
        if let term = term {
            let attributed = NSMutableAttributedString(string: foodName)
            let ranges = foodName.possibleRanges(for: term)
            let font = UIFont.systemFont(ofSize: 20, weight: .medium)
            let color = UIColor.darkText
            ranges.forEach({
                attributed.addAttributes([
                    .font: font, .foregroundColor: color], range: $0)
            })
            labelName.attributedText = attributed
        } else {
            labelName.text = foodName
        }
        labelGroup.text = result.group
        
        #if DEBUG
        labelNumber.text = result.ndbno
        #endif
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        let background = UIView()
        background.backgroundColor = UIColor(white: 0, alpha: 0.06)
        selectedBackgroundView = background
        #if DEBUG
        labelNumber.isHidden = false
        #endif
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension String {
    func possibleRanges(for term: String) -> [NSRange] {
        guard term.count > 3 else { return [] }
        var ranges: [NSRange] = []
        
        if term.rangeOfCharacter(from: .whitespaces) != nil { // multiple words
            let words = term.components(separatedBy: .whitespaces)
            words.forEach({ ranges += possibleRanges(for: $0) })
        } else {
            let line = self as NSString
            var range = line.range(of: term)
            if range.location != NSNotFound {
                ranges.append(range)
            } else {
                range = line.range(of: term.lowercased())
                if range.location != NSNotFound {
                    ranges.append(range)
                } else {
                    range = line.range(of: term.capitalized)
                    if range.location != NSNotFound {
                        ranges.append(range)
                    } else {
                        let word = String(term.dropLast())
                        ranges += possibleRanges(for: word)
                    }
                }
            }
        }
        
        return ranges
    }
}
