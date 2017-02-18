//
//  LocalSettingsTableViewController.swift
//  JokeSettings
//
//  Created by Gene Lee on 2/17/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class LocalSettingsTableViewController: UITableViewController {

    @IBOutlet weak var sortByLabel: UILabel!
    @IBOutlet weak var shuffleLabel: UILabel!
    @IBOutlet weak var sortByControl: UISegmentedControl!
    @IBOutlet weak var shuffleSwitch: UISwitch!
    
    @IBAction func SortByRatingControl(_ sender: UISegmentedControl) {
        let sortBy = sender.selectedSegmentIndex
        UserDefaults.standard.set(sortBy, forKey: "sort_by")
        if (sortBy == 0) {
            sortByLabel.text = "Sort By: Rating"
        } else if (sortBy == 1) {
            sortByLabel.text = "Sort By: Views"
        }
    }
    
    @IBAction func ShuffleOn(_ sender: UISwitch) {
        let shuffleOn = sender.isOn
        UserDefaults.standard.set(shuffleOn, forKey: "shuffle_on")
        if (shuffleOn) {
            shuffleLabel.text = "Shuffle: On"
        } else {
            shuffleLabel.text = "Shuffle: Off"
        }
    }
    
    // Checks if the settings are set in UserDefaults
    // If it hasn't, set to default settings
    func checkSettings () {
        if (UserDefaults.standard.object(forKey: "sort_by") != nil) {
            let sortBy = UserDefaults.standard.integer(forKey: "sort_by")
            if (sortBy == 0) {
                sortByLabel.text = "Sort By: Rating"
                sortByControl.selectedSegmentIndex = 0
            } else if (sortBy == 1) {
                sortByLabel.text = "Sort By: Views"
                sortByControl.selectedSegmentIndex = 1
            }
        } else {
            sortByLabel.text = "Sort By: Rating"
            sortByControl.selectedSegmentIndex = 0
        }
        if (UserDefaults.standard.object(forKey: "shuffle_on") != nil) {
            let shuffleOn = UserDefaults.standard.bool(forKey: "shuffle_on")
            if (shuffleOn) {
                shuffleLabel.text = "Shuffle: On"
                shuffleSwitch.setOn(true, animated: true)
            } else {
                shuffleLabel.text = "Shuffle: Off"
                shuffleSwitch.setOn(false, animated: true)
            }
        } else {
            shuffleLabel.text = "Shuffle: On"
            shuffleSwitch.setOn(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        checkSettings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // warning Incomplete implementation, return the number of rows
        return 2
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
