//
//  ViewController.swift
//  joker2
//
//  Created by Larry Holder on 1/18/17.
//  Copyright © 2017 Washington State University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstLineLabel: UILabel!
    @IBOutlet weak var secondLineLabel: UILabel!
    @IBOutlet weak var thirdLineLabel: UILabel!
    @IBOutlet weak var answerLineLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        // if Answer hidden, then unhide answer line and change button to New Joke
        // else choose new joke
        if (answerLineLabel.isHidden) {
            answerLineLabel.isHidden = false
            answerButton.setTitle("New Joke", for: .normal)
        } else {
            chooseJoke()
        }
    }
    
    var jokes: [Joke] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeJokes()
        chooseJoke()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeJokes() {
        var joke = Joke("How many programmers", "does it take to", "change a lightbulb?", "Zero. That's a hardware problem.")
        self.jokes.append(joke)
        joke = Joke("What did the fish say", "when it ran into a wall?", "", "Dam.")
        self.jokes.append(joke)
        joke = Joke("A horse walked into a bar,", "and the bartender said...", "", "Why the long face?")
        self.jokes.append(joke)
    }
    
    func chooseJoke() {
        // change button to "Answer"
        answerButton.setTitle("Answer", for: .normal)
        // hide answer label
        answerLineLabel.isHidden = true
        // choose a joke from the array at random
        let randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokes.count)))
        let joke = jokes[randomJokeIndex]
        // set view labels accordingly
        firstLineLabel.text = joke.firstLine
        secondLineLabel.text = joke.secondLine
        thirdLineLabel.text = joke.thirdLine
        answerLineLabel.text = joke.answerLine
    }


}

