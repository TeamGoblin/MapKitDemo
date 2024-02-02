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
    @State private var locations = [Location]()
    @State private var location = Location()
    @State private var lat = 0.0
    @State private var lon = 0.0

    //@State var camera: MapCameraPosition = .userLocation(fallback:.automatic)
    //@State private var cameraPosition = MapCameraPosition.region($model.region)
    var body: some View {
        VStack {
            // Basic way of doing this and can pass a .userLocation as a position
            //Map(position: $camera)
            
            // Old way of doing this
            //Map(coordinateRegion: $model.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $tracking)
            
            // New way of doing this
            /*
            Map(position: $model.position) {
                //Marker("Me", coordinate: model.tower)
                MapCircle(center:model.tower, radius: 150)
                    .foregroundStyle(.red.opacity(0.5))
                UserAnnotation(anchor: .center)
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            */
            
            
            MapReader { proxy in
                Map(initialPosition: model.position) {
                    MapCircle(center:model.tower, radius: 150)
                        .foregroundStyle(.red.opacity(0.5))
                    UserAnnotation(anchor: .center)
                    
                    /*
                    ForEach(locations) { location in
                        Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                    }
                     */
                    
                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                    
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        //locations = [(newLocation)]
                        location = newLocation
                        lat = coordinate.latitude
                        lon = coordinate.longitude
                        print("Tapped at \(coordinate)")
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                }
                .safeAreaInset(edge: .bottom){
                    HStack {
                        Spacer()
                        Button {
                            model.lat = lat
                            model.lon = lon
                            model.update()
                        } label: {
                            Text("Set Location")
                            .padding(10)
                        }
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        Spacer()
                    }
                }
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
