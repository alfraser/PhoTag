//
//  MissingPhotoView.swift
//  PhoTag
//
//  Created by Al Fraser on 19/07/2023.
//

import SwiftUI

struct MissingPhotoView: View {
    @State var description: String
    var id: UUID
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 300)
                .foregroundColor(.secondary)
            Text("Picture missing")
                .font(.largeTitle)
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text(description)
                        .asLabel()
                }
            }
        }
        .frame(height: 300)
        .padding(2.0)
        .withSystemImageButton(systemImage: "trash.fill") {
            print("Delete pressed")
        }
    }
}

struct MissingPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        MissingPhotoView(description: "Sample missing picture", id: UUID())
    }
}
