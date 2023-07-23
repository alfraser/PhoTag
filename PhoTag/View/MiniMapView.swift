//
//  MiniMapView.swift
//  PhoTag
//
//  Created by Al Fraser on 22/07/2023.
//

import MapKit
import SwiftUI

struct MiniMapView: View {
    @State private var coordinateRegion: MKCoordinateRegion
    @State private var marker: [IdentifiableLocationWrapper]
    
    struct IdentifiableLocationWrapper: Identifiable {
        let id = UUID()
        let location: CLLocationCoordinate2D
    }
    
    init(location: CLLocationCoordinate2D) {
        coordinateRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        marker = [IdentifiableLocationWrapper(location: location)]
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.blue, lineWidth: 6)
                .frame(width: 200, height: 200)
            Map(coordinateRegion: $coordinateRegion, annotationItems: marker) { m in
                MapMarker(coordinate: m.location)
            }
                .clipShape(Circle())
                .frame(width:200, height:200)
        }
    }
}

struct MiniMapView_Previews: PreviewProvider {
    static let loc = CLLocationCoordinate2D(latitude: 51.45264, longitude: -0.35219)
    
    static var previews: some View {
        MiniMapView(location: loc)
    }
}
