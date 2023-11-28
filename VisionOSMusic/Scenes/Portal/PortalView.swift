
import SwiftUI
import RealityKit

struct PortalView: View {
    
    static private let controlsAttachmentId = "controlsAttachmentId"

    @State private var viewModel = PortalViewModel()
    
    @ViewBuilder
    private var controls: some View {
        HStack {
            Toggle(isOn: $viewModel.lightOn) {
                Image(systemName: "lightbulb")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .symbolVariant(viewModel.lightOn ? .fill : .none)
                    .contentTransition(.symbolEffect(.replace))
                    .symbolEffect(.variableColor, value: viewModel.lightOn)
            }
            .toggleStyle(.button)
            .padding(.vertical)
            .rotationEffect(.degrees(90))
            
            Slider(value: $viewModel.lightValue, in: (10...50))
        }
        .padding(2)
        .frame(width: 320)
        .glassBackgroundEffect()
        .rotationEffect(.degrees(270))
    }
    
    var body: some View {
        RealityView { content, _ in
            let portalContent = viewModel.makePortalContent()
            let portal = viewModel.makePortal(content: portalContent)
            
            let wallAnchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2(1, 1)))
            
            let planeMesh = MeshResource.generatePlane(width: 3.75, depth: 2.625, cornerRadius: 0.1)
            
            let material = PostersView.loadImageMaterial(imageUrl: "playlist_rap")
            
            let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
            
            wallAnchor.addChild(planeEntity)
            wallAnchor.addChild(portalContent)
            wallAnchor.addChild(portal)
            
            content.add(wallAnchor)
            
        } update: { content, attachments in
            if let portalContent = viewModel.portalContent,
               let light = viewModel.getLight() {
                
                portalContent.components[ImageBasedLightComponent.self] = light
                
            }
            
            guard let attachmentEntity = attachments.entity(for: Self.controlsAttachmentId) else {
                return
            }
            
            let headAnchor = AnchorEntity(.head)
            attachmentEntity.position = [0.45, 0, -0.5]
            headAnchor.addChild(attachmentEntity)
            content.add(headAnchor)
            
        } attachments: {
            Attachment(id: Self.controlsAttachmentId) {
                controls
            }
        }
    }
}

#Preview {
    PortalView()
}
