
import SwiftUI
import RealityKit
import RealityKitContent

struct SnareDrumView: View {
    
    @Bindable private var viewModel = SnareDrumViewModel()
    
    @State private var isPickerVisible: Bool = false
    @State private var rotationTimer: Timer?
    
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
    }
    
    @ViewBuilder
    private var modelControlsView: some View {
        HStack(spacing: 17) {
            Toggle(isOn: $isPickerVisible) {
                Label("Sun", systemImage: "sun.max")
            }

            Toggle(isOn: $isPickerVisible) {
                Label("Poles", systemImage: "mappin.and.ellipse")
            }

            Toggle(isOn: $viewModel.rotateIsOn) {
                Label("Rotate", systemImage: "arrow.triangle.2.circlepath")
            }

            Toggle(isOn: $isPickerVisible) {
                Label("Tilt", systemImage: "cloud.sun.fill")
            }
        }
        .toggleStyle(.button)
        .buttonStyle(.borderless)
        .labelStyle(.iconOnly)
        .padding(12)
        .glassBackgroundEffect(in: .rect(cornerRadius: 50))
    }

    var body: some View {
        ZStack {
            snareRealityModel
         
            modelControlsView
                .offset(y: 124)
        }
        .onChange(of: viewModel.rotateIsOn) { _, rotateIsOn in
            if rotateIsOn {
                startRotation()
            } else {
                stopRotation()
            }
        }
    }
}

#Preview {
    SnareDrumView()
}
