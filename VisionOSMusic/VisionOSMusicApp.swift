
import SwiftUI
import RealityKitContent

@main
struct VisionOSMusicApp: App {
    
    // MARK: AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // MARK: ViewModels
    @State private var mainVM = MainViewModel()
    @State private var video360VM = Video360ViewModel()
    
    // MARK: Coordinators
    @State private var mainCoordinator = MainCoordinator()
    @State private var playlistsCoordinator = PlaylistsCoordinator()
    
    init() {
        realityKitRegister()
    }
    
    private func realityKitRegister() {
        BillboardSystem.registerSystem()
        BillboardComponent.registerComponent()
        
        DrumKitPieceComponent.registerComponent()
        DrumKitPieceRuntimeComponent.registerComponent()
        
//        ParticleTransitionSystem.registerSystem()
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
        
        WindowGroup(id: WindowName.video360Controls) {
            Video360ControlsView()
                .environment(video360VM)
        }
        .windowStyle(.plain)
        
        // MARK: Immersive spaces
        Group {
            ImmersiveSpace(id: WindowName.drumDemo) {
                DrumDemo()
            }
            .immersionStyle(selection: .constant(.mixed), in: .mixed)
            
            ImmersiveSpace(id: WindowName.posters) {
                PostersView()
            }
            .immersionStyle(selection: .constant(.mixed), in: .mixed)
            
            ImmersiveSpace(id: WindowName.videoPlayer) {
                Group {
                    if let videoclip = mainVM.immersionVideoclip {
                        VideoPlayerView(videoclip: videoclip)
                            .environment(mainVM)
                        
                    } else {
                        EmptyView()
                    }
                }
            }
            .immersionStyle(selection: $mainVM.immersionStyle,
                            in: .mixed, .progressive, .full)
            
            ImmersiveSpace(id: WindowName.portal) {
                PortalView()
            }
            
            ImmersiveSpace(id: WindowName.cube) {
                CubeView()
            }
            
            ImmersiveSpace(id: WindowName.portalLandscape) {
                PortalLandscapeView()
            }
            
            ImmersiveSpace(id: WindowName.video360) {
                Video360View()
                    .environment(video360VM)
            }
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: UIApplication) -> Bool {
        return true
    }
}
