//
//  ContentView.swift
//  MapKitDemo
//
//  Created by Jake Lake on 2/1/24.
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
    @EnvironmentObject var model: ContentModel
    //@State var camera: MapCameraPosition = .userLocation(fallback:.automatic)
    //@State private var cameraPosition = MapCameraPosition.region($model.region)
    var body: some View {
        VStack {
            // Basic way of doing this and can pass a .userLocation as a position
            //Map(position: $camera)
            
            // Old way of doing this
            //Map(coordinateRegion: $model.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $tracking)
            
            // New way of doing this
            Map(position: $model.position) {
                //Marker("Me", coordinate: model.tower)
                MapCircle(center:model.tower, radius: 150)
                    .foregroundStyle(.red.opacity(0.5))
                UserAnnotation(anchor: .center)
            }
        }
        .onAppear {
            //model.requestGeolocationPermission()
        }
    }
}

#Preview {
    ContentView()
}
