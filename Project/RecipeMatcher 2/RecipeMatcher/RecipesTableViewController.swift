//
//  RecipesTableViewController.swift
//  RecipeMatcher
//
//  Created by Gene Lee on 4/25/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import SafariServices

class RecipesTableViewController: UITableViewController {
    
    let apiKey: String = "1c9fa12a75107e8961a0dc9c8804d682"
    var i1: String = ""
    var i2: String = ""
    var i3: String = ""
    var i4: String = ""
    var i5: String = ""
    var recipes: [RecipeTableViewCell] = []
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func letsCookTapped() {
        self.food2ForkRecipes()
        self.yummlyRecipes()
        
    }
    
    func yummlyRecipes () {
        let urlStringYummly = "http://api.yummly.com/v1/api/recipes?_app_id=3b5d74af&_app_key=dbb25017fdd3446be417c5cd5ee86a51&q=\(i1)+\(i2)+\(i3)+\(i4)+\(i5)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: urlStringYummly!) {
            let dataTask = URLSession.shared.dataTask(with: url,completionHandler: handleRecipeResponseYummly)
            dataTask.resume()
        } else {
            print("error with url")
        }
    }
    
    func food2ForkRecipes () {
        var urlStringFood2Fork = "http://food2fork.com/api/search?key=\(apiKey)&q=\(i1),\(i2),\(i3),\(i4),\(i5)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if (i1 == "" && i2 == "" && i3 == "" && i4 == "" && i5 == "") {
            urlStringFood2Fork = "http://food2fork.com/api/search?key=\(apiKey)&q=".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        if let url = URL(string: urlStringFood2Fork!) {
            let dataTask = URLSession.shared.dataTask(with: url,completionHandler: handleRecipeResponseFood2Fork)
            dataTask.resume()
        } else {
            print("error with url")
        }
    }
    
    func handleRecipeResponseYummly (data: Data?, response: URLResponse?, error: Error?) {
        if (error != nil) {
            print("error: \(error!.localizedDescription)")
        }
        else {
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if statusCode != 200 {
                let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                print("HTTP \(statusCode) error: \(msg)")
            } else {
                // response okay, serialize data
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: []) {
                    let jsonDict = jsonObj as! [String: AnyObject]
                    let recipesArray = jsonDict["matches"] as! [AnyObject]
                    for recipe in recipesArray {
                        let recipesJSON = recipe as! [String: AnyObject]
                        let title = recipesJSON["recipeName"] as! String
                        let url = "http://www.yummly.com/recipe/" + (recipesJSON["id"] as! String)
                        let imageUrlJSON = recipesJSON["imageUrlsBySize"] as! [String: AnyObject]
                        let imageUrl = imageUrlJSON["90"] as! String
                        
                        //print("title: \(title), url: \(url), image: \(imageUrl)")
                        
                        let recipeCell = RecipeTableViewCell()
                        recipeCell.title = title
                        recipeCell.url = url
                        recipeCell.imageUrl = imageUrl
                        self.recipes.append(recipeCell)
                    }
                } else {
                    print("error: invalid JSON data")
                }
            }
        }
    }
    
    func handleRecipeResponseFood2Fork (data: Data?, response: URLResponse?, error: Error?) {
        if (error != nil) {
            print("error: \(error!.localizedDescription)")
        }
        else {
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if statusCode != 200 {
                let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                print("HTTP \(statusCode) error: \(msg)")
            } else {
                // response okay, serialize data
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: []) {
                    let jsonDict = jsonObj as! [String: AnyObject]
                    let recipesArray = jsonDict["recipes"] as! [AnyObject]
                    for recipe in recipesArray {
                        let recipesJSON = recipe as! [String: AnyObject]
                        let title = recipesJSON["title"] as! String
                        let url = recipesJSON["source_url"] as! String
                        let imageUrl = recipesJSON["image_url"] as! String
                        
                        //print("title: \(title), url: \(url), image: \(imageUrl)")
                        
                        let recipeCell = RecipeTableViewCell()
                        recipeCell.title = title
                        recipeCell.url = url
                        recipeCell.imageUrl = imageUrl
                        self.recipes.append(recipeCell)
                    }
                } else {
                    print("error: invalid JSON data")
                }
            }
        }
    }
    
    func getAndDisplayImage (_ recipeCell: RecipeTableViewCell) {
        let url = URL(string: recipeCell.imageUrl)
        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler: {(data,response,error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if statusCode != 200 {
                let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                print("HTTP \(statusCode) error: \(msg)")
            } else {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    recipeCell.recipeImage.image = image
                }
            }
        })
        dataTask.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.view.backgroundColor = UIColor.clear
        
        print("i1: \(i1), i2: \(i2), i3: \(i3), i4: \(i4), i5: \(i5)")
        self.letsCookTapped()
        
        // Refreshes after some time is given for async handlers to complete and reloads tableview
        // TODO: Will need to find a better method
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
        
        // Configure the cell...
        cell.title = self.recipes[indexPath.row].title
        cell.imageUrl = self.recipes[indexPath.row].imageUrl
        cell.url = self.recipes[indexPath.row].url
        
        cell.recipeLabel.text = self.recipes[indexPath.row].title
        self.getAndDisplayImage(cell)
        
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    // When cell is tapped go to the recipe in Safari
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RecipeTableViewCell
        let url = URL(string: cell.url)
        // open in safari view controller
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let alert = UIAlertController(title: "Looks good?", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Save to Favorites!", style: .default, handler: { (action) in
            // execute some code when this option is selected
            let cell = tableView.cellForRow(at: indexPath) as! RecipeTableViewCell
            Database.db.addToRecipeFavs(cell)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))

        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
