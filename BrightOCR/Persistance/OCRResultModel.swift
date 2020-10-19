//
//  OCRResultModel.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import Foundation

enum MappingError: Error {
    case missingData
}

struct OCRResultModel {
    let id: UUID
    let createdOn: Date
    let ocrText: String?
    
    init(_ coreDataObject: OCRResult) throws {
        guard let id = coreDataObject.id,
              let date = coreDataObject.createdOn else {
            throw MappingError.missingData
        }
        
        self.id = id
        self.createdOn = date
        self.ocrText = coreDataObject.ocrText
    }
    
    init(id: UUID, createdOn: Date, ocrText: String?) {
        self.id = id
        self.createdOn = createdOn
        self.ocrText = ocrText
    }
}
