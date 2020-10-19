//
//  ResultDetailsViewModel.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import UIKit

final class ResultDetailsViewModel {
    
    let result: OCRResultModel

    private let mainStore: MainStore
     
    init(result: OCRResultModel, mainStore: MainStore) {
        self.result = result
        self.mainStore = mainStore
    }
    
    func loadImage() -> UIImage? {
        return try? mainStore.imageStorage?.image(for: result.id)
    }

}
