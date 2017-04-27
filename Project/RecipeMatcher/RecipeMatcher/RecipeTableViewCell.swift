//
//  RecipeTableViewCell.swift
//  RecipeMatcher
//
//  Created by Gene Lee on 4/26/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    var title: String = ""
    var url: String = ""
    var imageUrl: String = ""
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
