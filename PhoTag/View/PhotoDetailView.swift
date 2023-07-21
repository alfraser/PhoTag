//
//  PhotoDetailView.swift
//  PhoTag
//
//  Created by Al Fraser on 18/07/2023.
//

import SwiftUI

struct PhotoDetailView: View {
    @State var photo: UIImage
    @State var description: String
    var id: UUID
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: photo)
                .resizable()
                .scaledToFit()
                .padding(3)
            Text(description)
                .asLabel()
        }
        .withSystemImageButton(systemImage: "trash.fill") {
            print("Delete pressed")
        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let examplePhoto = UIImage(named: "test")!
        PhotoDetailView(photo: examplePhoto, description: "A book we liked to read", id: UUID())
    }
}
