
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
        RealityView { content, _ in
            // Create an earth entity with tilt, rotation, a moon, and so on.
            do {
                let entity = try await Entity(named: "DrumDemoScene", in: realityKitContentBundle)
                
                
                content.add(entity)
            } catch {
                fatalError("Failed to load a model asset.")
            }

            // Store for later updates.
//            self.earthEntity = earthEntity

        } update: { content, attachments in
            // Reconfigure everything when any configuration changes.
//            earthEntity?.update(
//                configuration: earthConfiguration,
//                satelliteConfiguration: satelliteConfiguration,
//                moonConfiguration: moonConfiguration,
//                animateUpdates: animateUpdates)
            guard let attachmentEntity = attachments.entity(for: "Tag") else {
                print("RETURN")
                return }
            
            content.add(attachmentEntity)
            print("ADDED")
//            attachmentEntity.setPosition([0, 0.2, 0], relativeTo: content)
//            attachmentEntity.components.set()
            
        } attachments: {
            Image(systemName: "pencil.circle.fill")
                .tag("Tag")
        }
    }
}

#Preview {
    DrumDemo()
}
