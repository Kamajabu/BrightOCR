//
//  MainStore.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import Foundation

final class MainStore {
    
    private(set) lazy var coreDataStack: CoreDataStack = CoreDataStack()
    
    private(set) lazy var imageStorage: ImageStorage? = {
        do {
            return try ImageStorage()
        } catch {
            // TODO: Add logger
            return nil
        }
    }()
    
    func persistOCRResultModel(_ model: OCRResultModel) {
        coreDataStack.saveOCRResult(model)
    }
    
    func loadOCRResults() -> [OCRResultModel] {
        guard let results = try? coreDataStack.loadEntity(entity: OCRResult.self) else {
            return []
        }
        
        return results.compactMap { try? OCRResultModel($0) }
    }
    
    func deleteRecord(id: UUID) {
        do {
            try imageStorage?.removeImage(for: id)
            coreDataStack.removeEntity(entity: OCRResult.self, id: id)
        } catch {
            // TODO: Add logger
        }
    }
}
