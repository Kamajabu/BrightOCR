//
//  OCRResult+CoreDataProperties.swift
//  
//
//  Created by Kamajabu on 19/10/2020.
//
//

import Foundation
import CoreData

extension OCRResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OCRResult> {
        return NSFetchRequest<OCRResult>(entityName: "OCRResult")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var createdOn: Date?
    @NSManaged public var ocrText: String?
    
    convenience init(in context: NSManagedObjectContext, model: OCRResultModel) {
        self.init(context: context)
        self.id = model.id
        self.createdOn = model.createdOn
        self.ocrText = model.ocrText
    }

}
