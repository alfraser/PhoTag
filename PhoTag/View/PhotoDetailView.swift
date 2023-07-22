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
    @State var showMap = false
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottomTrailing) {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFit()
                    .padding(3)
                Text(description)
                    .asLabel()
            }
            VStack {
                Spacer()
                HStack {
                    if showMap {
                        Button {
                            showMap.toggle()
                        } label: {
                            Image(systemName: "arrow.down.left.circle")
                                .padding(8)
                                .background(.blue)
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.leading)
                        }
                    } else {
                        Button {
                            showMap.toggle()
                        } label: {
                            Image(systemName: "mappin.and.ellipse")
                                .padding(8)
                                .background(.blue)
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.leading)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let examplePhoto = UIImage(named: "test")!
        PhotoDetailView(photo: examplePhoto, description: "A book we liked to read")
    }
}
