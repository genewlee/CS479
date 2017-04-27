//
//  IngredientsNavViewController.swift
//  RecipeMatcher
//
//  Created by Gene Lee on 4/26/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class IngredientsNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "FoodPrep.png"))
        
        // don't blur and just shoe image
        let imageBackground = UIImageView(image: #imageLiteral(resourceName: "FoodPrep.png"))
        imageBackground.frame = self.view.frame
        imageBackground.contentMode = UIViewContentMode.scaleAspectFit
        self.view.insertSubview(imageBackground, at: 0)
        
        // Blur background image (from http://pinkstone.co.uk/how-to-apply-blur-effects-to-images-and-views-in-ios-8/)
        //        let blur = UIBlurEffect(style: .regular)
        //        let effectView = UIVisualEffectView(effect: blur)
        //        effectView.frame = self.view.frame
        //        self.view.insertSubview(effectView, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
