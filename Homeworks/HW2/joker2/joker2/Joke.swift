//
//  Joke.swift
//  joker2
//
//  Created by Larry Holder on 1/18/17.
//  Copyright © 2017 Washington State University. All rights reserved.
//

import Foundation

class Joke {
    var firstLine: String
    var secondLine: String
    var thirdLine: String
    var answerLine: String
    
    init(_ firstLine: String = "", _ secondLine: String = "", _ thirdLine: String = "", _ answerLine: String = "") {
        self.firstLine = firstLine
        self.secondLine = secondLine
        self.thirdLine = thirdLine
        self.answerLine = answerLine
    }
}
