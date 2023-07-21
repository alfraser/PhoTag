//
//  Model.swift
//  PhoTag
//
//  Created by Al Fraser on 18/07/2023.
//

import Foundation
import UIKit

struct TaggedPhoto: Identifiable, Codable, Equatable, Comparable {
    var id = UUID()
    var description = ""
    
    var image: UIImage? {
        if let img = UIImage(named: id.uuidString) {
            return img
        }
        if let img = ImageSaver.readJPEGFromDocumentsDirectory(id: id) {
            return img
        }
        return nil
    }
    
    static let example = TaggedPhoto(id: UUID(), description: "Example Photo")
    
    static func ==(lhs: TaggedPhoto, rhs: TaggedPhoto) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: TaggedPhoto, rhs: TaggedPhoto) -> Bool {
        lhs.description.lowercased() < rhs.description.lowercased()
    }
    
}
