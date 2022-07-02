//
//  CoreDataManager.swift
//  Data
//
//  Created by sona setiana on 02/07/22.
//

import Foundation
import CoreData

public class CoreDataManager {
    
    public init() {}
    
    lazy var presistenContainer: PersistentContainer = {
        let result = PersistentContainer(name: "WMCD")
        result.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        return result
    }()
    
    
    public func getPresistenContainer() -> NSPersistentContainer {
        return presistenContainer
    }
    
    public func getViewContext() -> NSManagedObjectContext {
        return presistenContainer.viewContext
    }
}


class PersistentContainer: NSPersistentContainer { }
