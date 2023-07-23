//
//  PhotoDetailView.swift
//  PhoTag
//
//  Created by Al Fraser on 18/07/2023.
//

import MapKit
import SwiftUI

struct PhotoDetailView: View {
    @State var photo: UIImage
    @State var description: String
    @State var showMap = false
    @State var location: CLLocationCoordinate2D?
    
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
            if let loc = location {
                VStack {
                    Spacer()
                    HStack {
                        if showMap {
                            MiniMapView(location: loc)
                                .padding(.leading)
                                .onTapGesture {
                                    showMap.toggle()
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
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let examplePhoto = UIImage(named: "test")!
        let loc = CLLocationCoordinate2D(latitude: 51.9977, longitude: 0.7407)
        return Group {
            PhotoDetailView(photo: examplePhoto, description: "A book we liked to read")
            PhotoDetailView(photo: examplePhoto, description: "A book we liked to read", location: loc)
        }
    }
}
