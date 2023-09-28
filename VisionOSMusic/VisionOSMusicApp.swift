
import SwiftUI
import RealityKitContent

@main
struct VisionOSMusicApp: App {
    
    @State private var drumDemoImmersionStyle: ImmersionStyle = .mixed
    @State private var postersImmersionStyle: ImmersionStyle = .mixed
    @State private var mainVM = MainViewModel()
    
    @State private var coordinator = PlaylistsCoordinator()
    
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
                .environment(coordinator)
        }
        .windowStyle(.plain)
        
        
        WindowGroup(id: WindowName.smallPlayer) {
            SmallPlayerView()
                .environment(mainVM)
        }
        .windowStyle(.plain)
        
        
        WindowGroup(id: WindowName.snareDrum) {
            SnareDrumView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.5, height: 0.5, depth: 0.5, in: .meters)
        
        
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
