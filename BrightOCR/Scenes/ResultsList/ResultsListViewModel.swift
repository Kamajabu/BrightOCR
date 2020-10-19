//
//  ResultsListViewModel.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import UIKit

final class ResultsListViewModel {
    
    private unowned let store: MainStore
    private let ocrEngine = FirebaseMLKitOCR()
    
    private(set) var resultsHistory: [OCRResultModel] = []
    
    init(store: MainStore) {
        self.store = store
    }
    
    func analyze(image: UIImage, completion: @escaping (Result<OCRResultModel, Error>) -> Void) {
        ocrEngine.performOCR(on: image) { [weak self] result in
            switch result {
            case let .failure(error):
                // Add logger
                completion(.failure(error))
            case let .success(text):
                let model = OCRResultModel(id: UUID(), createdOn: Date(), ocrText: text)
                self?.resultsMockData.append(model)
                completion(.success(model))
            }
        }
    }
    
}
