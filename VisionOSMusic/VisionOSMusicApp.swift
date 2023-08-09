
import SwiftUI

@main
struct VisionOSMusicApp: App {
    
    @State private var scenesVM = AppScenesViewModel()
    @State private var mainVM = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if scenesVM.didFinishInto {
                    MainView()
                        .environment(mainVM)
                    
                } else {
                    SplashView()
                }
            }
            .animation(.bouncy, value: scenesVM.didFinishInto)
        }
        .windowStyle(.plain)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
