//
//  MapKitDemoApp.swift
//  MapKitDemo
//
//  Created by Jake Lake on 2/1/24.
//

import SwiftUI
import SwiftData

@main
struct MapKitTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(ContentModel())
        }
    }
}
