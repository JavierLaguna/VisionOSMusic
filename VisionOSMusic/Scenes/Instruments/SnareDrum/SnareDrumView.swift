
import SwiftUI
import RealityKit
import RealityKitContent

struct SnareDrumView: View {
    
    private let offsetYVariation: CGFloat = 100
    private let offsetZVariation: CGFloat = 60
    
    @Bindable private var viewModel = SnareDrumViewModel()
    
    @State private var rotationTimer: Timer?
    @State private var controlsYOffset: CGFloat = 124
    @State private var controlsZOffset: CGFloat = 0
    
    private func startRotation() {
        guard let entity = viewModel.entity else {
            return
        }
        
        rotationTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            var transform = entity.transform
            transform.rotation = simd_quatf(angle: .pi, axis: SIMD3(0.0, 1.0, 0.0))
            
            viewModel.entity?.move(
                to: transform,
                relativeTo: viewModel.entity,
                duration: 3,
                timingFunction: .easeInOut
            )
        }
        
        rotationTimer?.fire()
    }
    
    private func stopRotation() {
        rotationTimer?.invalidate()
        rotationTimer = nil
    }
    
    private func showHead() {
        guard let entity = viewModel.entity else {
            return
        }
        
        var transform = entity.transform
        transform.rotation = simd_quatf(angle: .pi / 2, axis: SIMD3(1.0, 0.0, 0.0))
        
        viewModel.entity?.move(
            to: transform,
            relativeTo: viewModel.entity,
            duration: 1,
            timingFunction: .easeInOut
        )
        
        withAnimation(.bouncy.speed(1)) {
            controlsYOffset += offsetYVariation
            controlsZOffset += offsetZVariation
        }
    }
    
    private func showSide() {
        guard let entity = viewModel.entity else {
            return
        }
        
        var transform = entity.transform
        transform.rotation = simd_quatf(angle: -(.pi / 2), axis: SIMD3(1.0, 0.0, 0.0))
        
        viewModel.entity?.move(
            to: transform,
            relativeTo: viewModel.entity,
            duration: 1,
            timingFunction: .easeInOut
        )
        
        withAnimation(.bouncy.delay(0.5)) {
            controlsYOffset -= offsetYVariation
            controlsZOffset -= offsetZVariation
        }
    }
    
    @ViewBuilder
    private var snareRealityModel: some View {
        RealityView { content in
            do {
                let rootEntity = try await Entity(named: Scene3D.snareDrum, in: realityKitContentBundle)
                viewModel.entity = rootEntity
                content.add(rootEntity)
                
            } catch {
                fatalError("Failed to load a model asset.")
            }
        }
        .hoverEffect()
    }
    
    @ViewBuilder
    private var modelControlsView: some View {
        HStack(spacing: 16) {
            Toggle(isOn: $viewModel.rotateIsOn) {
                Label("Rotate", systemImage: "arrow.triangle.2.circlepath")
            }
            
            Toggle(isOn: $viewModel.isShowingHead) {
                Label("Show head", systemImage: "arrow.down.circle.fill")
            }
        }
        .toggleStyle(.button)
        .buttonStyle(.borderless)
        .labelStyle(.iconOnly)
        .padding(12)
        .glassBackgroundEffect(in: .capsule)
    }
    
    var body: some View {
        ZStack {
            snareRealityModel
            
            modelControlsView
                .offset(y: controlsYOffset)
                .offset(z: controlsZOffset)
        }
        .onChange(of: viewModel.rotateIsOn) { _, rotateIsOn in
            if rotateIsOn {
                startRotation()
            } else {
                stopRotation()
            }
        }
        .onChange(of: viewModel.isShowingHead) { _, isShowingHead in
            if isShowingHead {
                showHead()
            } else {
                showSide()
            }
        }
    }
}

#Preview {
    SnareDrumView()
}
