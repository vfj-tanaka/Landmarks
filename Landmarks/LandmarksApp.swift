//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by mtanaka on 2022/10/07.
//

import SwiftUI

@main
struct LandmarksApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
