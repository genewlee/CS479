//
//  IngredientsViewController.swift
//  RecipeMatcher
//
//  Created by Gene Lee on 4/24/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class IngredientsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ingredient_1TextField: UITextField!
    @IBOutlet weak var ingredient_2TextField: UITextField!
    @IBOutlet weak var ingredient_3TextField: UITextField!
    @IBOutlet weak var ingredient_4TextField: UITextField!
    @IBOutlet weak var ingredient_5TextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.clear
        
        ingredient_1TextField.delegate = self
        ingredient_2TextField.delegate = self
        ingredient_3TextField.delegate = self
        ingredient_4TextField.delegate = self
        ingredient_5TextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // getting rid of keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("Segue: segueToRecipeTableView")
        
        let recipeTableView = segue.destination as! RecipesTableViewController
        recipeTableView.i1 = ingredient_1TextField.text!
        recipeTableView.i2 = ingredient_2TextField.text!
        recipeTableView.i3 = ingredient_3TextField.text!
        recipeTableView.i4 = ingredient_4TextField.text!
        recipeTableView.i5 = ingredient_5TextField.text!

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
