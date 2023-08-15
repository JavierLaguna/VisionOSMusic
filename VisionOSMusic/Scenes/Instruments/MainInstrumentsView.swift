
import SwiftUI
import RealityKit
import RealityKitContent

struct MainInstrumentsView: View {
    
    private let modelDepth: Double = 200
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @State private var selection: Instrument = .drums
    @State private var isRotated = false
    
    private func rotateModel() {
        withAnimation(.bouncy) {
            isRotated.toggle()
        }
    }
    
    private func onChangeSelection() {
        isRotated = false
    }
    
    private func openDemo() {
        openWindow(id: WindowName.drumDemo)
    }
    
    var body: some View {
        VStack(spacing: 80) {
            Color.clear
                .overlay {
                    Model3D(named: selection.scene, bundle: realityKitContentBundle) { model in
                        model
                            .resizable()
                            .scaledToFit()
                            .rotation3DEffect(
                                Rotation3D(
                                    eulerAngles: .init(
                                        angles: [
                                            selection.sceneOrientation.x,
                                            isRotated ? 3.2: selection.sceneOrientation.y,
                                            selection.sceneOrientation.z
                                        ],
                                        order: .xyz
                                    )
                                )
                            )
                            .frame(depth: modelDepth)
                            .offset(z: -modelDepth / 2)
                        
                    } placeholder: {
                        LoadingView()
                            .offset(z: -modelDepth * 0.75)
                    }
                }
                .dragRotation(yawLimit: .degrees(20), pitchLimit: .degrees(20))
                .offset(z: modelDepth)
                .padding(100)
                .padding(.top, 32)
            
            HStack(spacing: 40) {
                Button("DEMO", action: openDemo)
                .isVisible(when: selection.hasDemo)
                .animation(.easeInOut, value: selection.hasDemo)
                
                Picker("Instruments", selection: $selection) {
                    ForEach(Instrument.allCases) { item in
                        Text(item.name)
                    }
                }
                .onChange(of: selection, onChangeSelection)
                .pickerStyle(.segmented)
                .frame(width: 324)
                
                Button(action: rotateModel) {
                    Image(systemName: "arrow.2.circlepath.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(8)
                }
                .isVisible(when: selection.canRotate)
                .animation(.easeInOut, value: selection.canRotate)
            }
            .padding(.bottom, 80)
        }
    }
}

#Preview {
    NavigationStack {
        MainInstrumentsView()
    }
}
