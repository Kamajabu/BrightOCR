//
//  CoreDataStack.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import CoreData

extension CoreDataStack {
    struct Const {
        static let containerName = "OCRResultData"
    }
}

final class CoreDataStack {
    
    func saveOCRResult(_ model: OCRResultModel) {
        _ = OCRResult(in: managedObjectContext, model: model)
        saveContext()
    }
    
    func loadEntity<T: NSManagedObject>(entity: T.Type, uuid: String? = nil) throws -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entity))
        
        if let definedId = uuid {
            fetchRequest.predicate = NSPredicate(format: "id == %@", definedId)
        }
        
        return try managedObjectContext.fetch(fetchRequest)
    }
    
    func removeEntity<T: NSManagedObject>(entity: T.Type, id: UUID) {
        guard let matchingEntities = try? loadEntity(entity: entity, uuid: id.uuidString) else {
            return
        }
        
        guard let record = matchingEntities.first else {
            return
        }
        
        managedObjectContext.delete(record)
        saveContext()
    }
    
    private var managedObjectContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    private  lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Const.containerName)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Add logger
            }
        })
        return container
    }()
    
    private func saveContext() {
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
