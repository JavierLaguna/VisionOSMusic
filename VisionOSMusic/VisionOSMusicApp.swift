//
//  VisionOSMusicApp.swift
//  VisionOSMusic
//
//  Created by Javier Laguna on 13/7/23.
//

import SwiftUI

@main
struct VisionOSMusicApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
