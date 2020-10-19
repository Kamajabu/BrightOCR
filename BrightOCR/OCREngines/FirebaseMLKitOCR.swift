//
//  FirebaseMLKitOCR.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import Foundation
import UIKit
import MLKit

class FirebaseMLKitOCR {
    
    typealias OCRResultBlock = (Result<String?, Error>)->Void
    
    func performOCR(on image: UIImage, completion: @escaping OCRResultBlock) {
        let textRecognizer = TextRecognizer.textRecognizer()
        
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        
        textRecognizer.process(visionImage) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(result?.text))
            }
        }
    }
}
