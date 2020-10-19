//
//  ResultDetailsViewModel.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import UIKit

final class ResultDetailsViewModel {
    
    let result: OCRResultModel
    let image: UIImage
     
    init(result: OCRResultModel, image: UIImage) {
        self.result = result
        self.image = image
    }

}
