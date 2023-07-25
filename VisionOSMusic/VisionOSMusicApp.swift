
import SwiftUI

@main
struct VisionOSMusicApp: App {
    
    @State private var mainVM = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(mainVM)
        }
        .windowStyle(.plain)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
