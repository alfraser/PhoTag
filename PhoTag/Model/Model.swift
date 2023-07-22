//
//  Model.swift
//  PhoTag
//
//  Created by Al Fraser on 18/07/2023.
//

import Foundation
import MapKit
import UIKit

struct TaggedPhoto: Identifiable, Codable, Equatable, Comparable {
    var id = UUID()
    var description = ""
    var latitude: Double?
    var longitude: Double?
    
    var image: UIImage? {
        if let img = UIImage(named: id.uuidString) {
            return img
        }
        if let img = ImageSaver.readJPEGFromDocumentsDirectory(id: id) {
            return img
        }
        return nil
    }
    
    var location: CLLocationCoordinate2D? {
        guard let latitude = latitude else { return nil }
        guard let longitude = longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = TaggedPhoto(id: UUID(), description: "Example Photo")
    
    static func ==(lhs: TaggedPhoto, rhs: TaggedPhoto) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: TaggedPhoto, rhs: TaggedPhoto) -> Bool {
        lhs.description.lowercased() < rhs.description.lowercased()
    }
    
}
