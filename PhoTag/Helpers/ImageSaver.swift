//
//  ImageSaver.swift
//  PhoTag
//
//  Created by Al Fraser on 19/07/2023.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error?) -> Void)?
    
    func writeToDocumentsDirectoryAsJPEG(image: UIImage, id: UUID) {
        let photoSavePath = FileManager.documentsDirectory.appendingPathComponent("\(id.uuidString).jpg")
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            do {
                try jpegData.write(to: photoSavePath, options: [.atomic, .completeFileProtection])
                successHandler?()
            } catch {
                errorHandler?(error)
            }
        } else {
            errorHandler?(nil)
        }
    }
    
    static func readJPEGFromDocumentsDirectory(id: UUID) -> UIImage? {
        let photoLoadPath = FileManager.documentsDirectory.appendingPathComponent("\(id.uuidString).jpg")
        return UIImage(contentsOfFile: photoLoadPath.path())
    }
}
