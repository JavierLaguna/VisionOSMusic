
import SwiftUI
import RealityKit
import RealityKitContent

struct MainInstrumentsView: View {
    
    private let modelDepth: Double = 200
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State private var selection: Instrument = .drums
    @State private var demoIsOpen = false
    @State private var isRotated = false
    
    private func rotateModel() {
        withAnimation(.bouncy) {
            isRotated.toggle()
        }
    }
    
    private func onChangeSelection() {
        isRotated = false
    }
    
    private func toggleDrumsDemo() {
        Task {
            if demoIsOpen {
                await dismissImmersiveSpace()
            } else {
                await openImmersiveSpace(id: WindowName.drumDemo)
            }
            
            demoIsOpen.toggle()
        }
    }
    
    private func toggleSnareDemo() {
        if demoIsOpen {
            dismissWindow(id: WindowName.snareDrum)
        } else {
            openWindow(id: WindowName.snareDrum)
        }
        
        demoIsOpen.toggle()
    }
    
    private func onPressDemoButton() {
        switch selection {
        case .drums:
            toggleDrumsDemo()
        case .snare:
            toggleSnareDemo()
        default:
            break
        }
    }
    
    @ViewBuilder
    private var instrumentModel3D: some View {
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
    
    var body: some View {
        VStack(spacing: 80) {
            Color.clear
                .overlay {
                    if selection == .sticks {
                        SticksModel3D()
                        
                    } else {
                        instrumentModel3D
                    }
                }
                .dragRotation(yawLimit: .degrees(20), pitchLimit: .degrees(20))
                .offset(z: modelDepth)
                .padding(100)
                .padding(.top, 32)
            
            HStack(spacing: 40) {
                Button(demoIsOpen ? "CLOSE" : "DEMO", action: onPressDemoButton)
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
