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
