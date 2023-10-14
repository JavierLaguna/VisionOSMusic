
import SwiftUI
import RealityKitContent

@main
struct VisionOSMusicApp: App {
    
    // MARK: AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // MARK: ImmersionStyles
    @State private var drumsetDemoImmersionStyle: ImmersionStyle = .mixed
    @State private var postersImmersionStyle: ImmersionStyle = .mixed
    
    // MARK: ViewModels
    @State private var mainVM = MainViewModel()
    
    // MARK: Coordinators
    @State private var mainCoordinator = MainCoordinator()
    @State private var playlistsCoordinator = PlaylistsCoordinator()
    
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
                .environment(mainCoordinator)
                .environment(playlistsCoordinator)
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
        .immersionStyle(selection: $drumsetDemoImmersionStyle, in: .mixed)
        
        
        ImmersiveSpace(id: WindowName.posters) {
            PostersView()
        }
        .immersionStyle(selection: $postersImmersionStyle, in: .mixed)
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
 
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: UIApplication) -> Bool {
        return true
    }
}
