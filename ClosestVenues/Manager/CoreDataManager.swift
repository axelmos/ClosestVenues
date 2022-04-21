//
//  CoreDataManager.swift
//  ClosestVenues
//
//  Created by Amosiejko on 20/04/2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    func getLastVenues() -> [Venue] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return [Venue]()
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StoredVenue")
        var storedVenues: [NSManagedObject] = []
        do {
            storedVenues = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        var venues = [Venue]()
        for storedVenue in storedVenues {
            let name = storedVenue.value(forKey: "name")
            venues.append(Venue.init(name: name as! String))
        }
        
        return venues
    }
    
    func saveLastVenues(venues: [Venue]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        for venue in venues {
            let entity = NSEntityDescription.entity(forEntityName: "StoredVenue", in: managedContext)!
            let storeVenue = NSManagedObject(entity: entity, insertInto: managedContext)
            storeVenue.setValue(venue.name, forKeyPath: "name")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteAllVenues() -> Bool {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StoredVenue")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                }
            }
            return true
        } catch let error as NSError {
            print("Deleted all my data in StoredVenue error : \(error) \(error.userInfo)")
            return false
        }
    }
}
