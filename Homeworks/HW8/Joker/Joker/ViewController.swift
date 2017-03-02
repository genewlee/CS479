//
//  ViewController.swift
//  Joker
//
//  Created by Gene Lee on 1/16/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var jokes = [Joke]()
    var jokeNum = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Programatically add swipe gestures
        /*let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDetected(recognizer:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDetected(recognizer:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)*/
        
        let FirstStarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StarTapDetected))
        firstStarImage.addGestureRecognizer(FirstStarTapGestureRecognizer)
        firstStarImage.isUserInteractionEnabled = true
        let SecondStarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StarTapDetected))
        secondStarImage.addGestureRecognizer(SecondStarTapGestureRecognizer)
        secondStarImage.isUserInteractionEnabled = true
        let ThirdStarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StarTapDetected))
        thirdStarImage.addGestureRecognizer(ThirdStarTapGestureRecognizer)
        thirdStarImage.isUserInteractionEnabled = true
        let FourthStarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StarTapDetected))
        fourthStarImage.addGestureRecognizer(FourthStarTapGestureRecognizer)
        fourthStarImage.isUserInteractionEnabled = true
        let FifthStarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StarTapDetected))
        fifthStarImage.addGestureRecognizer(FifthStarTapGestureRecognizer)
        fifthStarImage.isUserInteractionEnabled = true
        
        initializeJokes()
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
            //AnswerOutlet.setTitle("New Joke", for: .normal)
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
    @IBOutlet weak var JokeNumberLabel: UILabel!
    
    // Star Rating UIImageView's
    @IBOutlet weak var firstStarImage: UIImageView!
    @IBOutlet weak var secondStarImage: UIImageView!
    @IBOutlet weak var thirdStarImage: UIImageView!
    @IBOutlet weak var fourthStarImage: UIImageView!
    @IBOutlet weak var fifthStarImage: UIImageView!
    
    // Swiping to the left should advance to the next joke,
    // and if you swipe left on the last joke, the view should
    // change to the first joke. Swiping right should show the
    // previous joke, and if you swipe right on the first joke,
    // the view should change to the last joke.
    @IBAction func swipeDetected (recognizer: UISwipeGestureRecognizer) {
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.right:
            print("Swiped right")
            jokeNum = (jokeNum + jokes.count - 1) % jokes.count
        case UISwipeGestureRecognizerDirection.left:
            print("Swiped left")
            jokeNum = (jokeNum + 1) % jokes.count
        default:
            break
        }
        chooseJoke()
        setRating()
    }
    
    @IBAction func StarTapDetected (recognizer: UITapGestureRecognizer) {
        let joke = jokes[jokeNum]
        
        switch recognizer.view! {
        case firstStarImage:
            print ("first star tapped")
            if (joke.rating == 1 && firstStarImage.image == UIImage(named: "Star Filled-32.png")!) {
                joke.rating = 0
            } else {
                joke.rating = 1
            }
        case secondStarImage:
            print ("second star tapped")
            joke.rating = 2
        case thirdStarImage:
            print ("third star tapped")
            joke.rating = 3
        case fourthStarImage:
            print ("fourth star tapped")
            joke.rating = 4
        case fifthStarImage:
            print ("fifth star tapped")
            joke.rating = 5
        default:
            break
        }
        setRating()
    }
    
    func setRating () {
        let joke = jokes[jokeNum]
        
        firstStarImage.image = UIImage(named: "Star-32.png")
        secondStarImage.image = UIImage(named: "Star-32.png")
        thirdStarImage.image = UIImage(named: "Star-32.png")
        fourthStarImage.image = UIImage(named: "Star-32.png")
        fifthStarImage.image = UIImage(named: "Star-32.png")
        
        if (joke.rating > 0) {
            firstStarImage.image = UIImage(named: "Star Filled-32.png")!
        }
        if (joke.rating > 1) {
            secondStarImage.image = UIImage(named: "Star Filled-32.png")!
        }
        if (joke.rating > 2) {
            thirdStarImage.image = UIImage(named: "Star Filled-32.png")!
        }
        if (joke.rating > 3) {
            fourthStarImage.image = UIImage(named: "Star Filled-32.png")!
        }
        if (joke.rating > 4) {
            fifthStarImage.image = UIImage(named: "Star Filled-32.png")!
        }
    }
    
    /// Creates at least three different jokes and stores them in the jokes array
    func initializeJokes() {
        // Joke(first: "first line", second: "second line", third: "third line", answer: "answer line")
        // if a argument is not passed in, it is "" by default
        
        // Joke 1
        let joke1 = Joke(first: "Why did the python programmer", second: "have crooked teeth?", answer: "No braces")
        self.jokes.append(joke1)
        
        // Joke 2
        let joke2 = Joke(first: "How many programmers", second: "does it take to", third: "change a lightbulb?", answer: "Zero. That's a hardware problem.")
        self.jokes.append(joke2)
        
        // Joke 3
        let joke3 = Joke(first: "Why do the java programmers", second: "where glasses?", answer: "Because they can't C#")
        self.jokes.append(joke3)
        
        // Joke 4
        let joke4 = Joke(first: "Why are Assembly programmers", second: "always soaking wet?", answer: "They work below C-level.")
        self.jokes.append(joke4)
        
        // Joke 5
        let joke5 = Joke(first: "Why do programmers always mix up", second: "Halloween and Christmas?", answer: "Because Oct 31 == Dec 25!")
        self.jokes.append(joke5)
    }
    
    /// Randomly selects one of the jokes in the array and sets the line labels appropriately
    func chooseJoke() {
        // initally set answer line to hidden
        Punchline.isHidden = true
        
        // set the answer button title
        AnswerOutlet.setTitle("Answer", for: .normal)
        
        // gets a random index into jokes array
        //var randomJokeIndex = Int(arc4random_uniform(UInt32((self.jokes.count))))
        
        // don't show the same joke directly after // not the best implementation to check
        /*while (jokes[randomJokeIndex].firstLine == FirstLineOutlet.text) {
            randomJokeIndex = Int(arc4random_uniform(UInt32((self.jokes.count))))
        }*/
        
        // get the Joke object
        let joke: Joke = jokes[jokeNum]
        
        // set the line labels appropriately
        JokeNumberLabel.text = "Joke #\(jokeNum + 1)"
        FirstLineOutlet.text = joke.firstLine
        SecondLineOutlet.text = joke.secondLine
        ThirdLineOutlet.text = joke.thirdLine
        Punchline.text = joke.answerLine
    }
}

