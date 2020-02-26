//
//  SchoolTableViewCell.swift
//  NYCSchools
//
//  Created by Amit Patel on 2/23/20.
//  Copyright © 2020 Amit Patel. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {

    
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    
    @IBOutlet weak var schoolOverviewLabel: UILabel!
    
    // MARK:- Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessibilityTraits = .button
    }

    // MARK:- Configuration methods
    
    func configureCellWithName(_ schoolName:String, overView:String) {
        schoolNameLabel.text = schoolName
        schoolOverviewLabel.text = overView
        accessibilityLabel = schoolName + overView
    }
}
