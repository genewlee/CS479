//
//  Joke.swift
//  Joker
//
//  Created by Gene Lee on 1/20/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class JokeDb {
    
    static let db = JokeDb() // singleton -- shared instance used throughout app
    
    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!
    
    init () {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = self.appDelegate.persistentContainer.viewContext
    }
    
    func addJoke (first: String = "", second: String = "", third: String = "", answer: String = "") {
        let joke = NSEntityDescription.insertNewObject(forEntityName: "Joke", into: self.context)
        joke.setValue(first, forKey: "lineOne")
        joke.setValue(second, forKey: "lineTwo")
        joke.setValue(third, forKey: "lineThree")
        joke.setValue(answer, forKey: "lineAnswer")
        
        self.appDelegate.saveContext()
    }
    
    func removeJoke (_ first: String, _ answer: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Joke")
        let lineOnePred = NSPredicate(format: "lineOne == %@", first)
        let answerPred = NSPredicate(format: "lineAnswer == %@", answer)

        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [lineOnePred, answerPred])
        do {
            let jokes = try self.context.fetch(fetchRequest)
            let joke = jokes.first!
            
            self.context.delete(joke)
        } catch {
                print("removeJoke error: \(error)")
        }
        
        self.appDelegate.saveContext()
    }
    
    func editJoke (line: String, first: String, second: String, third: String, answer: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Joke")
        fetchRequest.predicate = NSPredicate(format: "lineOne == %@", line)
        
        do {
            let jokes = try self.context.fetch(fetchRequest)
            let joke = jokes.first!
            
            joke.setValue(first, forKey: "lineOne")
            joke.setValue(second, forKey: "lineTwo")
            joke.setValue(third, forKey: "lineThree")
            joke.setValue(answer, forKey: "lineAnswer")
        } catch {
            print("editJoke error: \(error)")
        }
        
        self.appDelegate.saveContext()
    }
    
    func fetchJoke(first: String) -> Joke {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Joke")
        fetchRequest.predicate = NSPredicate(format: "lineOne == %@", first)
        
        var joke: Joke!
        do {
            let jokes = try self.context.fetch(fetchRequest)
            joke = jokes.first! as! Joke
            
            return joke
        } catch {
            print("editJoke error: \(error)")
        }
        return joke
    }
    
    func fetchJokes() -> JokeArray {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Joke")
        var tempJokes: [NSManagedObject]!
        do {
            tempJokes = try self.context.fetch(fetchRequest)
        } catch {
            print("fetchJokes error: \(error)")
        }
        let jokes = JokeArray()
        for joke in tempJokes {
            jokes.add(joke as! Joke)
        }
        return jokes
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
