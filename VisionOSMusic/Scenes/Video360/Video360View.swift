
import SwiftUI
import RealityKit
import AVFoundation

struct Video360View: View {
    
    static private let defaultVideoName = "beach_headland"
    static private let defaultVideoExtension = "mp4"
    
    @Environment(\.openWindow) private var openWindow
    
    @Environment(Video360ViewModel.self) private var viewModel
    
    var body: some View {
        RealityView { content in
            let videoEntity = ModelEntity()
            let material = VideoMaterial(avPlayer: viewModel.player)
            videoEntity.components.set(ModelComponent(
                mesh: .generateSphere(radius: 1E3),
                materials: [material]
            ))

            videoEntity.scale *= .init(x: -1, y: 1, z: 1)
            videoEntity.transform.translation += SIMD3<Float>(0.0, 1.0, 0.0)

            let angle = Angle.degrees(90)
            let rotation = simd_quatf(angle: Float(angle.radians), axis: SIMD3<Float>(0, 1, 0))
            videoEntity.transform.rotation = rotation

            content.add(videoEntity)
        }
        .transition(.opacity)
        .upperLimbVisibility(.hidden)
        .onAppear {
            openWindow(id: WindowName.video360Controls)
            
            viewModel.load(
                name: Self.defaultVideoName,
                extenstion: Self.defaultVideoExtension
            )
        }
    }
}
