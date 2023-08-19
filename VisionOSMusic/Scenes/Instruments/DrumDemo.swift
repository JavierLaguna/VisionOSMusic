
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
            do { // DrumDemoScene // SticksScene
                let entity = try await Entity(named: "DrumDemoScene", in: realityKitContentBundle)
//                entity.setScale([0.5, 0.5, 0.5], relativeTo: entity)
                entity.position = SIMD3<Float>(0, 0, -2)
                
                let audio = try await AudioFileResource.load(named: "kick")
                
                if let emmiter = entity.findEntity(named: "KickEmiter") {
                    emmiter.playAudio(audio)
                }
                
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
            attachmentEntity.setPosition([0, 0.2, 0.5], relativeTo: content.entities.first)
            //            attachmentEntity.components.set()
            
        } attachments: {
            Image(systemName: "pencil.circle.fill")
                .tag("Tag")
        }
        .gesture(TapGesture().targetedToAnyEntity().onEnded({ entity in
            //            var transform = entity.entity.transform
            //            transform.translation = SIMD3(0.1, 0, -0.1)
            //            entity.entity.move(
            //                to: transform,
            //                relativeTo: nil,
            //                duration: 3,
            //                timingFunction: .easeInOut
            //            )
            
            let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                var transform = entity.entity.transform
                let radians = 90.0 * Float.pi / 100.0
                transform.rotation *= simd_quatf(angle: radians, axis: SIMD3(0.0, 0.0, 1.0))
                
                entity.entity.move(
                    to: transform,
                    relativeTo: nil,
                    duration: 3,
                    timingFunction: .easeInOut
                )
            }
            
            timer.fire()
        }))
    }
}

#Preview {
    DrumDemo()
}
