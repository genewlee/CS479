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
    var rating: Int
    
    init (first: String = "", second: String = "", third: String = "", answer: String = "") {
        self.firstLine = first
        self.secondLine = second
        self.thirdLine = third
        self.answerLine = answer
        self.rating = 0
    }
}
