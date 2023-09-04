
import SwiftUI
import RealityKit
import RealityKitContent

struct DrumDemo: View {
    
    private let runtimeQuery = EntityQuery(where: .has(DrumKitPieceRuntimeComponent.self))
    
    private var viewModel = DrumDemoViewModel()
    
    @State private var subscriptions = [EventSubscription]()
    @State private var attachmentsProvider = AttachmentsProvider()
    @State private var attachmentsVisibles = true
    
    private func createDrumKitPieceView(for entity: Entity) {
        guard entity.components[DrumKitPieceRuntimeComponent.self] == nil,
              let drumKitPiece = entity.components[DrumKitPieceComponent.self] else {
            return
        }
        
        let tag: ObjectIdentifier = entity.id
        let view = DrumPieceView(
            type: drumKitPiece.type,
            onPressPlayButton: {
                onTapPlay(of: drumKitPiece.type)
            }
        ).tag(tag)
        
        entity.components[DrumKitPieceRuntimeComponent.self] = DrumKitPieceRuntimeComponent(attachmentTag: tag)
        attachmentsProvider.attachments[tag] = AnyView(view)
    }
    
    private func hideAttachments() {
        withAnimation(.smooth) {
            attachmentsVisibles = false
        }
    }
    
    private func showAttachments() {
        withAnimation(.smooth) {
            attachmentsVisibles = true
        }
    }
    
    private func onTapPlay(of piece: DrumKitPieceComponent.PieceType) {
        Task {
            hideAttachments()
            await viewModel.onTapPlay(of: piece)
            showAttachments()
        }
    }
    
    var body: some View {
        RealityView { content, _ in
            do {
                let rootEntity = try await Entity(named: Scene3D.DrumDemo.name, in: realityKitContentBundle)
                viewModel.rootEntity = rootEntity
                rootEntity.position = SIMD3<Float>(0, 0, -2)
                content.add(rootEntity)
                
                let stickEntity = rootEntity.findEntity(named: Scene3D.DrumDemo.Sticks.ride)
                //  stickEntity.components.set(ControlledOpacityComponent(shouldShow: false))
                stickEntity?.components.set(OpacityComponent(opacity: 0.0))
                viewModel.stickEntity = stickEntity
                
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
                attachmentEntity.components.set(OpacityComponent(opacity: attachmentsVisibles ? 1.0 : 0.0))
            }
            
        } attachments: {
            ForEach(attachmentsProvider.sortedTagViewPairs, id: \.tag) { pair in
                pair.view
            }
        }
    }
}

#Preview {
    DrumDemo()
}
