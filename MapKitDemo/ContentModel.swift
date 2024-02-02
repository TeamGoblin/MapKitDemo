//
//  ContentModel.swift
//  MapKitDemo
//
//  Created by Jake Lake on 2/1/24.
//

import Foundation
import SwiftUI
import SwiftData
import CoreLocation
import MapKit

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    @Published var location = CLLocation()
    @Published var locationManager = CLLocationManager()
    @Published var region = MKCoordinateRegion()
    @Published var tower = CLLocationCoordinate2D()
    @Published var position:MapCameraPosition = .userLocation(fallback:.automatic)
    @Published var lat = 0.0
    @Published var lon = 0.0
    
    override init() {
        super.init()
        
        // Set ContentModel as delegate of the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    /*
    func requestGeolocationPermission() {
        
        // Request Authorization
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    // Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission
            // Start geolocation the user, after getting auth
            locationManager.startUpdatingLocation()
            
        } else if locationManager.authorizationStatus == .denied {
          
            // Permission denied
            
        } else {
            
            // We don't have permission for another reason
            
        }
    }
    */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of the user
        /*
        let userLocation = locations.first
        
        if userLocation != nil {
            location = userLocation!
            // Can stop requesting the location in this function if only needed once
            // locationManager.stopUpdatingLocation()
        }
        */
        
        locations.last.map {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
            )
            tower = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            position = MapCameraPosition.region(region)
            lat = $0.coordinate.latitude
            lon = $0.coordinate.longitude
        }
    }
    
    func update() {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
            span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        )
        tower = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        position = MapCameraPosition.region(region)
    }
}
