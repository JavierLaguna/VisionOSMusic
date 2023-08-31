
import SwiftUI
import RealityKit
import RealityKitContent

struct SplashView: View {
    
    @AppStorage(BusinessConstants.UserDefaults.introEnabled)
    private var introEnabled: Bool = BusinessConstants.DefaultValues.introEnabled
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    private func start() async {
        if introEnabled {
            await TimerUtils.waitTime(time: .seconds(6))
        }
        
        await MainActor.run {
            openWindow(id: WindowName.main)
        }
        
        await TimerUtils.waitTime(time: .seconds(0.25))
        
        await MainActor.run {
            dismissWindow(id: WindowName.splash)
        }
    }
    
    var body: some View {
        VStack {
            Color.clear
                .overlay {
                    Model3D(named: Scene3D.intro, bundle: realityKitContentBundle) { model in
                        model
                            .resizable()
                            .scaledToFit()
                            .frame(depth: 200)
                        
                    } placeholder: {
                        LoadingView()
                    }
                }
                .padding(.vertical, 40)
        }
        .padding(48)
        .task {
            await start()
        }
    }
}

#Preview {
    SplashView()
}
