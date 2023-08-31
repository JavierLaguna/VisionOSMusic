
import SwiftUI
import RealityKit
import RealityKitContent

struct SnareDrumView: View {
    
    var body: some View {
        ZStack {
            SnareModelView()
         
            ModelControlsView()
                .offset(y: 124)
        }
    }
}

private struct SnareModelView: View {
    
    var body: some View {
        Model3D(named: Scene3D.snareDrum, bundle: realityKitContentBundle)
    }
}

private struct ModelControlsView: View {
    
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
