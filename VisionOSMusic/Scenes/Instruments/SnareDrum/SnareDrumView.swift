
import SwiftUI
import RealityKit
import RealityKitContent

struct SnareDrumView: View {
    
    @State private var viewModel = SnareDrumViewModel()
    
    var body: some View {
        ZStack {
            SnareModelView()
                .environment(viewModel)
         
            ModelControlsView()
                .offset(y: 124)
                .environment(viewModel)
        }
    }
}

private struct SnareModelView: View {
    
    @Environment(SnareDrumViewModel.self) private var viewModel
    
    @State private var entity: Entity?
    
    var body: some View {
        RealityView { content in
            do {
                let rootEntity = try await Entity(named: Scene3D.snareDrum, in: realityKitContentBundle)
                entity = rootEntity
//                rootEntity.position = SIMD3<Float>(0, 0, -2)
//                content.add(rootEntity)
//                
//                subscriptions.append(content.subscribe(to: ComponentEvents.DidAdd.self, componentType: DrumKitPieceComponent.self, { event in
//                    createDrumKitPieceView(for: event.entity)
//                }))
                
            } catch {
                fatalError("Failed to load a model asset.")
            }
        }
    }
}

private struct ModelControlsView: View {
    
    @Environment(SnareDrumViewModel.self) private var viewModel
    
    @State private var isPickerVisible: Bool = false
    
    var body: some View {
        HStack(spacing: 17) {
            Toggle(isOn: $isPickerVisible) {
                Label("Sun", systemImage: "sun.max")
            }

            Toggle(isOn: $isPickerVisible) {
                Label("Poles", systemImage: "mappin.and.ellipse")
            }

            Toggle(isOn: $isPickerVisible) {
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
}

#Preview {
    SnareDrumView()
}
