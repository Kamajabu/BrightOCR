//
//  MainStore.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

final class MainStore {
    
    private(set) lazy var coreDataStack: CoreDataStack = CoreDataStack()
    
    private(set) lazy var imageStorage: ImageStorage? = {
        do {
            return try ImageStorage()
        } catch {
            // TODO: Replace with logger
            return nil
        }
    }()
    
    func persistOCRResultModel(_ model: OCRResultModel) {
        let context = coreDataStack.managedObjectContext
        _ = OCRResult(in: context, model: model)
        coreDataStack.saveContext()
    }
    
    func loadOCRResults() -> [OCRResultModel] {
        guard let results = try? coreDataStack.loadEntity(entity: OCRResult.self) else {
            return []
        }
        
        return results.compactMap { try? OCRResultModel($0) }
    }
}
