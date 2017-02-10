//
//  JokeViewController.swift
//  Joker
//
//  Created by Gene Lee on 1/16/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController {
    
    var jokes = JokeArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeJokes()
        chooseJoke()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        // Joke(first: "first line", second: "second line", third: "third line", answer: "answer line")
        // if a argument is not passed in, it is "" by default
        
        // Joke 1
        let joke1 = Joke(first: "Why did the python programmer", second: "have crooked teeth?", answer: "No braces")
        self.jokes.add(joke1)
        
        // Joke 2
        let joke2 = Joke(first: "How many programmers", second: "does it take to", third: "change a lightbulb?", answer: "Zero. That's a hardware problem.")
        self.jokes.add(joke2)
        
        // Joke 3
        let joke3 = Joke(first: "Why do the java programmers", second: "where glasses?", answer: "Because they can't C#")
        self.jokes.add(joke3)
        
        // Joke 4
        let joke4 = Joke(first: "Why are Assembly programmers", second: "always soaking wet?", answer: "They work below C-level.")
        self.jokes.add(joke4)
        
        // Joke 5
        let joke5 = Joke(first: "Why do programmers always mix up", second: "Halloween and Christmas?", answer: "Because Oct 31 == Dec 25!")
        self.jokes.add(joke5)
    }
    
    /// Randomly selects one of the jokes in the array and sets the line labels appropriately
    func chooseJoke() {
        
        if (jokes.count < 1) {
            FirstLineOutlet.text = "No Jokes"
            SecondLineOutlet.text = ""
            ThirdLineOutlet.text = ""
            Punchline.text = ""
            return
        }
        
        // initally set answer line to hidden
        Punchline.isHidden = true
        
        // set the answer button title
        AnswerOutlet.setTitle("Answer", for: .normal)
        
        // gets a random index into jokes array
        var randomJokeIndex = Int(arc4random_uniform(UInt32((self.jokes.count))))
        
        // don't show the same joke directly after // not the best implementation to check
        while (jokes.count > 1 && jokes.getJoke(randomJokeIndex).firstLine == FirstLineOutlet.text) {
            randomJokeIndex = Int(arc4random_uniform(UInt32((self.jokes.count))))
        }
        
        // get the Joke object
        let joke: Joke = jokes.getJoke(randomJokeIndex)
        
        // set the line labels appropriately
        FirstLineOutlet.text = joke.firstLine
        SecondLineOutlet.text = joke.secondLine
        ThirdLineOutlet.text = joke.thirdLine
        Punchline.text = joke.answerLine
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // sets number of jokes to AddJokeViewController
        if (segue.identifier == "toTableView") {
            let tableViewController = segue.destination as! TableViewController
            tableViewController.jokes = self.jokes
        }
    }
    
    @IBAction func unwindfromTableView (segue: UIStoryboardSegue) {
        let tableVC = segue.source as! TableViewController
        self.jokes = tableVC.jokes
        self.chooseJoke()
    }
    
}

