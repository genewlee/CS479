//
//  ProductTableViewCell.swift
//  RecipeMatcher
//
//  Created by Gene Lee on 4/25/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    var name: String = ""
    var date: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
