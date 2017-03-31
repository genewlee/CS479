//
//  JokeViewController.swift
//  Joker
//
//  Created by Gene Lee on 1/16/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import CoreData

class JokeViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    var jokes = JokeArray()
    //var jokes: [NSManagedObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // for db
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = self.appDelegate.persistentContainer.viewContext
        
        // Set up db only on app if first launched
        if (UserDefaults.standard.object(forKey: "firstLaunch") == nil) {
            print("first launch, init db")
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            self.initializeJokes()
        } else {
            print("not first launch")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        chooseJoke()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// When the “Answer” button is tapped, the answer line should be unhidden, 
    /// and the button title should change to “New Joke”
    /// When the “New Joke” button is tapped, call chooseJoke()
    @IBAction func AnswerTapped(_ sender: Any) {
        if AnswerOutlet.currentTitle == "Answer" {
            Punchline.isHidden = !Punchline.isHidden
            
            // set the answer button title for new joke
            AnswerOutlet.setTitle("New Joke", for: .normal)
        }
        else { // show next joke when pressed
            chooseJoke()
        }
    }
    
    @IBOutlet weak var AnswerOutlet: UIButton!
    @IBOutlet weak var Punchline: UILabel!
    @IBOutlet weak var FirstLineOutlet: UILabel!
    @IBOutlet weak var SecondLineOutlet: UILabel!
    @IBOutlet weak var ThirdLineOutlet: UILabel!
    
    /// Creates at least three different jokes and stores them in the jokes array
    func initializeJokes() {
        
        // Joke 1
        JokeDb.db.addJoke(first: "Why did the python programmer", second: "have crooked teeth?", answer: "No braces")
        
        // Joke 2
        JokeDb.db.addJoke(first: "How many programmers", second: "does it take to", third: "change a lightbulb?", answer: "Zero. That's a hardware problem.")
        
        // Joke 3
        JokeDb.db.addJoke(first: "Why do the java programmers", second: "where glasses?", answer: "Because they can't C#")
        
        // Joke 4
        JokeDb.db.addJoke(first: "Why are Assembly programmers", second: "always soaking wet?", answer: "They work below C-level.")
        
        // Joke 5
        JokeDb.db.addJoke(first: "Why do programmers always mix up", second: "Halloween and Christmas?", answer: "Because Oct 31 == Dec 25!")
    }
    
    /// Randomly selects one of the jokes in the array and sets the line labels appropriately
    func chooseJoke() {
        
        self.jokes = JokeDb.db.fetchJokes() // get jokes from db
        
        if (jokes.count < 1) {
            FirstLineOutlet.text = "No Jokes"
            SecondLineOutlet.text = ""
            ThirdLineOutlet.text = ""
            Punchline.text = ""
            AnswerOutlet.setTitle("New Joke", for: .normal)
            return
        }
        
        // initally set answer line to hidden
        Punchline.isHidden = true
        
        // set the answer button title
        AnswerOutlet.setTitle("Answer", for: .normal)
        
        // gets a random index into jokes array
        var randomJokeIndex = Int(arc4random_uniform(UInt32((self.jokes.count))))
        
        // don't show the same joke directly after // not the best implementation to check
        while (self.jokes.count > 1 && self.jokes.getJoke(randomJokeIndex).lineOne == FirstLineOutlet.text) {
            randomJokeIndex = Int(arc4random_uniform(UInt32((self.jokes.count))))
        }
        
        // get the Joke object
        let joke: Joke = self.jokes.getJoke(randomJokeIndex)
        
        // set the line labels appropriately
        FirstLineOutlet.text = joke.lineOne
        SecondLineOutlet.text = joke.lineTwo
        ThirdLineOutlet.text = joke.lineThree
        Punchline.text = joke.lineAnswer
    }
    
}

