
import SwiftUI

@main
struct VisionOSMusicApp: App {
    
    @State private var mainVM = MainViewModel()
    
    var body: some Scene {

        WindowGroup(id: WindowName.splash) {
            SplashView()
        }
        .windowStyle(.plain)
        
        
        WindowGroup(id: WindowName.main) {
            MainView()
                .environment(mainVM)
        }
        .windowStyle(.plain)
        
        
        WindowGroup(id: WindowName.smallPlayer) {
            SmallPlayerView()
                .environment(mainVM)
        }
        .windowStyle(.plain)
    }
}
