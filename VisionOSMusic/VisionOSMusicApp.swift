
import SwiftUI
import RealityKitContent

@main
struct VisionOSMusicApp: App {
    
    @State private var drumDemoImmersionStyle: ImmersionStyle = .mixed
    @State private var postersImmersionStyle: ImmersionStyle = .mixed
    @State private var mainVM = MainViewModel()
    
    init() {
        BillboardSystem.registerSystem()
        BillboardComponent.registerComponent()
        
        DrumKitPieceComponent.registerComponent()
        DrumKitPieceRuntimeComponent.registerComponent()
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
        
        
        //        WindowGroup(id: WindowName.drumDemo) {
        //            DrumDemo()
        //        }
        //        .windowStyle(.volumetric)
        //        .defaultSize(width: 1, height: 1, depth: 1, in: .meters)
        
        
        ImmersiveSpace(id: WindowName.drumDemo) {
            DrumDemo()
        }
        .immersionStyle(selection: $drumDemoImmersionStyle, in: .mixed)
        
        
        ImmersiveSpace(id: WindowName.posters) {
            PostersView()
        }
        .immersionStyle(selection: $postersImmersionStyle, in: .mixed)
    }
}
