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
        
        resultsHistory = store.loadOCRResults()
    }
    
    func saveResult(_ image: UIImage, ocrText: String?) -> OCRResultModel {
        
        let key = UUID()
        do {
            try store.imageStorage?.setImage(image, for: key)
        } catch {
            // Add logger
        }
        
        let model = OCRResultModel(id: key, createdOn: Date(), ocrText: ocrText)
        store.persistOCRResultModel(model)

        return model
    }
    
    func historyRecord(for indexRow: Int) -> OCRResultModel? {
        guard resultsHistory.indices.contains(indexRow) else {
            // Add logger
            return nil
        }
        
        return resultsHistory[indexRow]
    }
    
    func analyze(image: UIImage, completion: @escaping (Result<OCRResultModel, Error>) -> Void) {
        ocrEngine.performOCR(on: image) { result in
            switch result {
            case let .failure(error):
                // Add logger
                completion(.failure(error))
            case let .success(text):
                let model = self.saveResult(image, ocrText: text)
                self.addModelToHistoryList(model)
                completion(.success(model))
            }
        }
    }
    
    func deleteRecord(id: UUID) {
        resultsHistory.removeAll { $0.id == id }
        store.deleteRecord(id: id)
    }
    
    private func addModelToHistoryList(_ model: OCRResultModel) {
        resultsHistory.append(model)
    }
    
}
