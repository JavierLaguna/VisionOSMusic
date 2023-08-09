
import SwiftUI
import RealityKit
import RealityKitContent

struct SplashView: View {
    
    var body: some View {
        VStack {
            Color.clear
                .overlay {
                    Model3D(named: "IntroScene", bundle: realityKitContentBundle) { model in
                        model
                            .resizable()
                            .scaledToFit()
                            .frame(depth: 200)
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
                .padding(.vertical, 40)
        }
        .padding(48)
    }
}

#Preview {
    SplashView()
}
