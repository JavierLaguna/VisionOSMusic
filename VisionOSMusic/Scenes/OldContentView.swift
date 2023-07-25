
import SwiftUI
import RealityKit
import RealityKitContent

struct OldContentView: View {
    
    @State var showImmersiveSpace = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        NavigationSplitView {
            List {
                Text("Item")
            }
            .navigationTitle("Sidebar")
        } detail: {
            VStack {
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)

                Text("Hello, world!")

                Toggle("Show ImmersiveSpace", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
                    .padding(.top, 50)
                
                //                Color.clear
                //                    .overlay {
                //                        Model3D(named: "gramophone") { model in
                //                            model
                //                                .resizable()
                //                                .scaledToFit()
                //                                .rotation3DEffect(
                //                                    Rotation3D(
                //                                        eulerAngles: .init(angles: orientation, order: .xyz)
                //                                    )
                //                                )
                //                                .frame(depth: modelDepth)
                //                                .offset(z: -modelDepth / 2)
                //
                //                            //                        .frame(width: 80, height: 80)
                //
                //                        } placeholder: {
                //                            ProgressView()
                //                        }
                //                    }
                //                    .dragRotation(yawLimit: .degrees(200), pitchLimit: .degrees(200), sensitivity: 1)
                //                    .offset(z: modelDepth)
            }
            .navigationTitle("Content")
            .padding()
        }
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    await openImmersiveSpace(id: "ImmersiveSpace")
                } else {
                    await dismissImmersiveSpace()
                }
            }
        }
    }
}

#Preview {
    OldContentView()
}

