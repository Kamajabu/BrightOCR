//
//  CoreDataStack.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import CoreData

final class CoreDataStack {
    private static let containerName = "OCRImagesData"

    var managedObjectContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

   private  lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.containerName)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Add logger
            }
        })
        return container
    }()
    
    func saveContext() {
        self.managedObjectContext.perform {
            if self.managedObjectContext.hasChanges {
                do {
                    try self.managedObjectContext.save()
                } catch {
                    // Add logger
                }
            }
        }
    }

}
