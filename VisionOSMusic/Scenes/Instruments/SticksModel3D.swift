
import SwiftUI
import RealityKit
import RealityKitContent

struct SticksModel3D: View {
    
    var body: some View {
        RealityView { content in
            do {
                let rootEntity = try await Entity(named: Scene3D.sticks, in: realityKitContentBundle)
                print(rootEntity.parameterNames)
                print(rootEntity.parameters)
                
                content.add(rootEntity)
                
                
            } catch {
                fatalError("Failed to load a model asset.")
            }
        }
    }
}

#Preview {
    SticksModel3D()
        .glassBackgroundEffect()
}
