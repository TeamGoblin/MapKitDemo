//
//  Location.swift
//  MapKitDemo
//
//  Created by Jake Lake on 2/1/24.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var description: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}
