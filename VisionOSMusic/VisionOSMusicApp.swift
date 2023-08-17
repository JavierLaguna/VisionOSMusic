
import SwiftUI
import RealityKitContent

@main
struct VisionOSMusicApp: App {
    
    @State private var drumDemoImmersionStyle: ImmersionStyle = .mixed
    @State private var mainVM = MainViewModel()
    
    init() {
        DrumKitPieceComponent.registerComponent()
    }
    
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
        
        
        ImmersiveSpace(id: WindowName.drumDemo) {
            DrumDemo()
        }
        .immersionStyle(selection: $drumDemoImmersionStyle, in: .mixed)
        
        
//        WindowGroup(id: WindowName.drumDemo) {
//            SplashView()
//        }
//        .windowStyle(.volumetric)
//        .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
    }
}
