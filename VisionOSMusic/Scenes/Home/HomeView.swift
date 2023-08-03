
import SwiftUI
import RealityKit

import RealityKitContent

struct HomeView: View {
    
    private let modelDepth: Double = 200
    private let orientation: SIMD3<Double> = [0.15, 0, 0.15]
    
    var body: some View {
        VStack {
            Color.clear
                .overlay {
                    Model3D(named: "wheel", bundle: realityKitContentBundle) { model in
                        model
                            .resizable()
                            .scaledToFit()
                            .rotation3DEffect(
                                Rotation3D(
                                    eulerAngles: .init(angles: orientation, order: .xyz)
                                )
                            )
                            .frame(depth: modelDepth)
//                            .offset(z: modelDepth)
                            .frame(width: 80, height: 80)
//                            .dragRotation(yawLimit: .degrees(2), pitchLimit: .degrees(2))
                        
                    } placeholder: {
                        ProgressView()
                    }
                    
                }
                .dragRotation(yawLimit: .degrees(20), pitchLimit: .degrees(20))
            //                    .offset(z: modelDepth)
            
            Text("HomeView")
        }
        .padding(48)
    }
}

#Preview {
    HomeView()
        .environment(MainViewModel())
        .glassBackgroundEffect()
}
