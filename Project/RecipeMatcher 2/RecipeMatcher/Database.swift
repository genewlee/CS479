//
//  Database.swift
//  RecipeMatcher
//
//  Created by Gene Lee on 4/24/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Database {
    
    static let db = Database() // singleton -- shared instance used throughout app
    
    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!
    
    init () {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = self.appDelegate.persistentContainer.viewContext
    }
    
    // MARK: Grocery/Shopping List
    
    func fetchShoppingList() -> [NSManagedObject]? {
        let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        
        do {
            // get the results
            let searchResults = try self.context.fetch(fetchRequest)
            
            print ("num of log results = \(searchResults.count)")
            
            // convert to NSManagedObejct to use 'for' loops
            /*for product in searchResults as [NSManagedObject] {
                print ("\(product.value(forKey: "product")!) \(product.value(forKey: "date")!)")
            }*/
            return searchResults as [NSManagedObject]
        } catch {
            print("Error with request \(error)")
        }
        return nil
    }
    
    func addToShoppingList (_ product: String) {
        // retrieve the entity
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingList", in: context)
        
        let slist = NSManagedObject(entity: entity!, insertInto: context)
        slist.setValue(product, forKey: "product")
        slist.setValue("\(Date())", forKey: "date")
        self.appDelegate.saveContext()
    }
    
    func removeFromShoppingList (_ product: String, _ date: String) {
        let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        let productPred = NSPredicate(format: "product == %@", argumentArray: [product])
        let datePred = NSPredicate(format: "date == %@", argumentArray: [date])
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [productPred, datePred])
        fetchRequest.predicate = predicate
        
        do {
            let searchResult = try context.fetch(fetchRequest) as [NSManagedObject]
            let prod = searchResult.first!
            
            context.delete(prod)
            self.appDelegate.saveContext()
            print("Removed product: \(product)")
        } catch {
            print("Error with request \(error)")
        }
    }
    
    func editItemShoppingList (_ product: String, _ date: String, _ editedProduct: String) {
        let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        let productPred = NSPredicate(format: "product == %@", argumentArray: [product])
        let datePred = NSPredicate(format: "date == %@", argumentArray: [date])
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [productPred, datePred])
        fetchRequest.predicate = predicate
        
        do {
            let searchResult = try context.fetch(fetchRequest) as [NSManagedObject]
            let prod = searchResult.first!
            
            prod.setValue(editedProduct, forKey: "product")
            self.appDelegate.saveContext()
            print("Edited product: \(product)")
        } catch {
            print("Error with request \(error)")
        }
    }
    
    // MARK: Favorite Recipes
    
    func addToRecipeFavs (_ cell: RecipeTableViewCell) {
        // retrieve the entity
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: context)
        
        let fav = NSManagedObject(entity: entity!, insertInto: context)
        fav.setValue(cell.title, forKey: "title")
        fav.setValue(cell.url, forKey: "url")
        fav.setValue(cell.imageUrl, forKey: "imageUrl")
        
        self.appDelegate.saveContext()
    }
    
    func fetchFavoritesList() -> [NSManagedObject]? {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            // get the results
            let searchResults = try self.context.fetch(fetchRequest)
            
            print ("num of log results = \(searchResults.count)")
            
            // convert to NSManagedObejct to use 'for' loops
            /*for fav in searchResults as [NSManagedObject] {
                print ("\(fav.value(forKey: "title")!), \(fav.value(forKey: "url")!), \(fav.value(forKey: "imageUrl")!)")
            }*/
            return searchResults as [NSManagedObject]
        } catch {
            print("Error with request \(error)")
        }
        return nil
    }
    
    func removeFromFavoritesList (_ cell: RecipeTableViewCell) {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let titlePred = NSPredicate(format: "title == %@", argumentArray: [cell.title])
        let urlPred = NSPredicate(format: "url == %@", argumentArray: [cell.url])
        let imgPred = NSPredicate(format: "imageUrl == %@", argumentArray: [cell.imageUrl])
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [titlePred, urlPred, imgPred])
        fetchRequest.predicate = predicate
        
        do {
            let searchResult = try context.fetch(fetchRequest) as [NSManagedObject]
            let fav = searchResult.first!
            
            context.delete(fav)
            self.appDelegate.saveContext()
            print("Removed fav: \(cell.title)")
        } catch {
            print("Error with request \(error)")
        }
    }
}
