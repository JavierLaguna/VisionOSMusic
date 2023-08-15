
import SwiftUI
import RealityKit
import RealityKitContent

struct DrumDemo: View {
    
    var body: some View {
        Drum()
    }
}

private struct Drum: View {
    
    var body: some View {
        RealityView { content in
            // Create an earth entity with tilt, rotation, a moon, and so on.
            do {
                let entity = try await Entity(named: Scene3D.drums, in: realityKitContentBundle)
                
                
                
                let transformAnimation = FromToByAnimation(
                    name: "transform",
                    from: transform,
                    to: end,
                    duration: 0.25,
                    timing: .easeInOut,
                    isAdditive: false,
                    bindTarget: .transform)
                let resource = try AnimationResource.generate(with: transformAnimation)
                
                
//                content.add(entity)
                
                let entityS = try await Entity(named: "StickScene", in: realityKitContentBundle)
                
                entityS.playAnimation(resource)
                
                content.add(entityS)
            } catch {
                fatalError("Failed to load a model asset.")
            }

            // Store for later updates.
//            self.earthEntity = earthEntity

        } update: { content in
            // Reconfigure everything when any configuration changes.
//            earthEntity?.update(
//                configuration: earthConfiguration,
//                satelliteConfiguration: satelliteConfiguration,
//                moonConfiguration: moonConfiguration,
//                animateUpdates: animateUpdates)
        }
    }
}

#Preview {
    DrumDemo()
}
