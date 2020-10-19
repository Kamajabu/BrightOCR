//
//  ImageStorage.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import UIKit

final class ImageStorage {
    
    private static let defaultStorageName = "ImagesStorage"
    
    private let fileManager: FileManager
    private let path: String
    
    init(name: String = ImageStorage.defaultStorageName,
         fileManager: FileManager = FileManager.default) throws {
        self.fileManager = fileManager

        let url = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let path = url.appendingPathComponent(name, isDirectory: true).path
        self.path = path
        
        try createDirectory()
        try fileManager.setAttributes([.protectionKey: FileProtectionType.complete], ofItemAtPath: path)
    }
    
    func setImage(_ image: UIImage, for key: UUID) throws {
        guard let data = image.pngData() else {
            throw Error.invalidImage
        }
        let filePath = makeFilePath(for: key.uuidString)
        _ = fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
    }
    
    func image(for key: UUID) throws -> UIImage {
        let filePath = makeFilePath(for: key.uuidString)
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
        guard let image = UIImage(data: data) else {
            throw Error.invalidImage
        }
        return image
    }
    
    private func makeFileName(for key: String) -> String {
        let fileExtension = URL(fileURLWithPath: key).pathExtension
        return fileExtension.isEmpty ? key : "\(key).\(fileExtension)"
    }

    private func makeFilePath(for key: String) -> String {
        return "\(path)/\(makeFileName(for: key))"
    }
    
    private func createDirectory() throws {
        guard !fileManager.fileExists(atPath: path) else {
            return
        }
        
        try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    }
}

private extension ImageStorage {
    
    enum Error: Swift.Error {
        case invalidImage
    }
}
