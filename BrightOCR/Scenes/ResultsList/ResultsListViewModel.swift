//
//  ResultsListViewModel.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import Foundation

final class ResultsListViewModel {
    
    private unowned let store: MainStore
    
    let mock1 = OCRResultModel(id: UUID(), createdOn: Date(), ocrResult: "Test 1")
    let mock2 = OCRResultModel(id: UUID(), createdOn: Date(timeIntervalSince1970: 8547892146), ocrResult: "Test 2")
    let mock3 = OCRResultModel(id: UUID(), createdOn: Date(timeIntervalSince1970: 43242321), ocrResult: "Test 3")

    lazy var resultsMockData = [mock1, mock2, mock3]
    
    init(store: MainStore) {
        self.store = store
    }
    
}
