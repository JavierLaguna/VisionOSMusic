
import SwiftUI
import RealityKit

struct PortalLandscapeView: View {
    
    static private let controlsAttachmentId = "controlsAttachmentId"
    
    @State private var viewModel = PortalLandscapeViewModel()

    @ViewBuilder
    private var controls: some View {
        VStack {
            Button(action: viewModel.randomImmersiveBg) {
                Image(systemName: "camera.rotate")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 42, height: 36)
            }
        }
        .padding()
        .glassBackgroundEffect()
    }
    
    var body: some View {
        RealityView { content, _ in
            let portalContent = viewModel.makePortalContent()
            let portal = viewModel.makePortal(content: portalContent)
            
            let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2(3, 3)))
            
            wallAnchor.addChild(portalContent)
            wallAnchor.addChild(portal)
            
            content.add(wallAnchor)
            
        } update: { content, attachments in
            if let attachmentEntity = attachments.entity(for: Self.controlsAttachmentId) {
                let headAnchor = AnchorEntity(.head)
                attachmentEntity.position = [0.45, 0, -0.5]
                headAnchor.addChild(attachmentEntity)
                content.add(headAnchor)
            }
            
        } attachments: {
            Attachment(id: Self.controlsAttachmentId) {
                controls
            }
        }
    }
}

#Preview {
    PortalLandscapeView()
}
