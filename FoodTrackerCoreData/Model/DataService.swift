//
//  DataService.swift
//  FoodTrackerCoreData
//
//  Created by KuAnh on 21/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit
import CoreData

class DataService {
    static let shared: DataService = DataService()
    
    var fetchResultsController: NSFetchedResultsController<Meal> {
        
        if _fetchResultsController != nil {
            return _fetchResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        let nameStdSort = NSSortDescriptor(key: "name", ascending: false)
        
        fetchRequest.sortDescriptors = [nameStdSort]
        
        _fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.context, sectionNameKeyPath: nil, cacheName: "Master")
        
        do {
            try _fetchResultsController?.performFetch()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
        return _fetchResultsController!
    }
    
    var _fetchResultsController: NSFetchedResultsController<Meal>?
}
