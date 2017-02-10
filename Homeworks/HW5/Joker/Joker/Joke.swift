//
//  Joke.swift
//  Joker
//
//  Created by Gene Lee on 1/20/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import Foundation


class Joke {
    var firstLine: String
    var secondLine: String
    var thirdLine: String
    var answerLine: String
    
    init (first: String = "", second: String = "", third: String = "", answer: String = "") {
        self.firstLine = first
        self.secondLine = second
        self.thirdLine = third
        self.answerLine = answer
    }
}

class JokeArray {
    private var jokes: [Joke]
    var count: Int { get { return jokes.count } }
    
    init() {
        jokes = [Joke]()
    }
    
    func add (_ joke: Joke) {
        self.jokes.append(joke)
    }
    
    func getJoke (_ index: Int) -> Joke {
        return jokes[index]
    }
    
    func remove (_ index: Int) {
        jokes.remove(at: index)
    }
}
