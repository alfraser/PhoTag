//
//  TaggedPhotoDetailView.swift
//  PhoTag
//
//  Created by Al Fraser on 19/07/2023.
//

import SwiftUI

struct TaggedPhotoDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var taggedPhoto: TaggedPhoto
    
    var body: some View {
        ZStack {
            if let img = taggedPhoto.image {
                PhotoDetailView(photo: img, description: taggedPhoto.description, id: taggedPhoto.id)
            } else {
                MissingPhotoView(description: taggedPhoto.description, id: taggedPhoto.id)
            }
        }
        .withSystemImageButton(systemImage: "trash.fill") {
            print("Delete pressed")
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct TaggedPhotoDetailView_Previews: PreviewProvider {
    static var exampleWithPhoto = TaggedPhoto(id: UUID(uuidString: "7A9160C8-458D-42ED-BC9D-D44068DC6793")!, description: "Test image")
    static var exampleWithoutPhoto = TaggedPhoto.example
    
    static var previews: some View {
        TaggedPhotoDetailView(taggedPhoto: exampleWithPhoto)
        TaggedPhotoDetailView(taggedPhoto: exampleWithoutPhoto)
    }
}
