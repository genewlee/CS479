//
//  ShoppingTableViewController.swift
//  RecipeMatcher
//
//  Created by Gene Lee on 4/24/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import CoreData

class ShoppingTableViewController: UITableViewController {
    
    var shoppingList: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Set background to clear so we can see navigation controller image background
        self.view.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadTableData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadTableData () {
        shoppingList = Database.db.fetchShoppingList()!
        shoppingList.sort(by: {$1.value(forKey: "date") as! String > $0.value(forKey: "date") as! String}) // sort by product date
        self.tableView.reloadData()
    }

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Item", message: "Add item to list", preferredStyle: .alert)
        alert.addTextField(configurationHandler: newItemTextFieldHandler)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            // execute some code when this option is selected
            let item = alert.textFields?[0].text
            Database.db.addToShoppingList(item!) // Add new item to db
            self.loadTableData() // refresh table from db
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func newItemTextFieldHandler (_ textField: UITextField) {
        textField.autocorrectionType = .yes
        textField.placeholder = "Item"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ProductTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductTableViewCell
        
        cell.date = shoppingList[indexPath.row].value(forKey: "date") as! String
        cell.name = shoppingList[indexPath.row].value(forKey: "product") as! String

        // Configure the cell...
        cell.textLabel?.text = (shoppingList[indexPath.row].value(forKey: "product") as! String)
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cell = tableView.cellForRow(at: indexPath) as! ProductTableViewCell
            
            // Delete the row from the data source
            Database.db.removeFromShoppingList(cell.name, cell.date)
            self.shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } //else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //}
    }
    
    // Cell accessory button tapped -> edit the item
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProductTableViewCell
        
        let alert = UIAlertController(title: "Edit Item:", message: "\(cell.name)", preferredStyle: .alert)
        alert.addTextField(configurationHandler: newItemTextFieldHandler)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (action) in
            // edit the product item
            let item = alert.textFields?[0].text
            Database.db.editItemShoppingList(cell.name, cell.date, item!) // edit item to db
            self.loadTableData() // refresh table from db
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
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
