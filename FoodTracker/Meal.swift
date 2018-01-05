//
//  Meal.swift
//  FoodTracker
//
//  Created by Christopher Thiebaut on 12/5/17.
//  Copyright © 2017 Christopher Thiebaut. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding{
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //This seems super questionable to put in the meals class. Strictly speaking, the location where instances of the model are to be archived doesn't seem related to the model itself.
    //MARK: Archiving Paths:
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //Mark Types
    struct PropertyKey{
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        guard !name.isEmpty else{
            return nil
        }
        
        guard rating >= 0 && rating <= 5 else{
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //name is required, so the initializer should fail if it is absent.`
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("Unable to decode the name for a meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        //photo is optional, so a conditional cast is fine.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        //decodeInteger(forKey:) will throw an exception if the value associated with the key is not an Integer.
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        //Use the designated initializer to create a meal instance with the decoded values.
        self.init(name: name, photo: photo, rating: rating)
    }
}
