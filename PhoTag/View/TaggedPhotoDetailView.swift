//
//  TaggedPhotoDetailView.swift
//  PhoTag
//
//  Created by Al Fraser on 19/07/2023.
//

import MapKit
import SwiftUI

struct TaggedPhotoDetailView: View {
    @State var taggedPhoto: TaggedPhoto
    var viewModel: ContentView.ViewModel
    
    var body: some View {
        ZStack {
            if let img = taggedPhoto.image {
                PhotoDetailView(photo: img, description: taggedPhoto.description, location: taggedPhoto.location)
            } else {
                MissingPhotoView(description: taggedPhoto.description)
            }
        }
        .withSystemImageButton(systemImage: "trash.fill") {
            viewModel.deletePhoto(id: taggedPhoto.id)
        }
    }
}

struct TaggedPhotoDetailView_Previews: PreviewProvider {
    static var exampleWithoutPhoto = TaggedPhoto.example
    static var exampleWithPhoto = TaggedPhoto(id: UUID(uuidString: "7A9160C8-458D-42ED-BC9D-D44068DC6793")!, description: "Test image")
    static var exampleWithPhotoAndLoc = TaggedPhoto(id: UUID(uuidString: "7A9160C8-458D-42ED-BC9D-D44068DC6793")!, description: "Test image", latitude: 51.9977, longitude: 0.7407)
    
    static var previews: some View {
        TaggedPhotoDetailView(taggedPhoto: exampleWithoutPhoto, viewModel: ContentView.ViewModel())
        TaggedPhotoDetailView(taggedPhoto: exampleWithPhoto, viewModel: ContentView.ViewModel())
        TaggedPhotoDetailView(taggedPhoto: exampleWithPhotoAndLoc, viewModel: ContentView.ViewModel())
    }
}
