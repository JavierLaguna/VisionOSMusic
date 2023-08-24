
import SwiftUI
import RealityKit
import RealityKitContent

struct DrumDemo: View {
    
    private let runtimeQuery = EntityQuery(where: .has(DrumKitPieceRuntimeComponent.self))
    
    private var viewModel = DrumDemoViewModel()
    
    @State private var subscriptions = [EventSubscription]()
    @State private var attachmentsProvider = AttachmentsProvider()
    
    private func createDrumKitPieceView(for entity: Entity) {
        guard entity.components[DrumKitPieceRuntimeComponent.self] == nil,
              let drumKitPiece = entity.components[DrumKitPieceComponent.self] else {
            return
        }
        
        let tag: ObjectIdentifier = entity.id
        let view = DrumPieceView(
            type: drumKitPiece.type,
            onPressPlayButton: {
                viewModel.playSound(of: drumKitPiece.type)
            }
        ).tag(tag)
        
        entity.components[DrumKitPieceRuntimeComponent.self] = DrumKitPieceRuntimeComponent(attachmentTag: tag)
        attachmentsProvider.attachments[tag] = AnyView(view)
    }
    
    var body: some View {
        RealityView { content, _ in
            do {
                let rootEntity = try await Entity(named: Scene3D.drumsDemo, in: realityKitContentBundle)
                viewModel.rootEntity = rootEntity
                rootEntity.position = SIMD3<Float>(0, 0, -2)
                content.add(rootEntity)
                
                subscriptions.append(content.subscribe(to: ComponentEvents.DidAdd.self, componentType: DrumKitPieceComponent.self, { event in
                    createDrumKitPieceView(for: event.entity)
                }))
                
            } catch {
                fatalError("Failed to load a model asset.")
            }
            
        } update: { content, attachments in
            
            viewModel.setupAudio()
            
            viewModel.rootEntity?.scene?.performQuery(runtimeQuery).forEach { entity in
                guard let component = entity.components[DrumKitPieceRuntimeComponent.self],
                      let attachmentEntity = attachments.entity(for: component.attachmentTag) else {
                    return
                }
                
                viewModel.rootEntity?.addChild(attachmentEntity)
                attachmentEntity.setPosition([0, 0.15, 0], relativeTo: entity)
                attachmentEntity.components.set(BillboardComponent())
            }
            
        } attachments: {
            ForEach(attachmentsProvider.sortedTagViewPairs, id: \.tag) { pair in
                pair.view
            }
        }
        //        .gesture(TapGesture().targetedToAnyEntity().onEnded({ entity in
        //            var transform = entity.entity.transform
        //            transform.translation = SIMD3(0.1, 0, -0.1)
        //            entity.entity.move(
        //                to: transform,
        //                relativeTo: nil,
        //                duration: 3,
        //                timingFunction: .easeInOut
        //            )
        
        //            let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
        //                var transform = entity.entity.transform
        //                let radians = 90.0 * Float.pi / 100.0
        //                transform.rotation *= simd_quatf(angle: radians, axis: SIMD3(0.0, 0.0, 1.0))
        //
        //                entity.entity.move(
        //                    to: transform,
        //                    relativeTo: nil,
        //                    duration: 3,
        //                    timingFunction: .easeInOut
        //                )
        //            }
        //
        //            timer.fire()
        //        }))
    }
}

#Preview {
    DrumDemo()
}
