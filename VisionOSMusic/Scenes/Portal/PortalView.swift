
import SwiftUI
import RealityKit

struct PortalView: View {
    
    static private let controlsAttachmentId = "controlsAttachmentId"
    
    @State private var viewModel = PortalViewModel()
    
    private var lightIsOn: Binding<Bool> {
        Binding(
            get: {
                viewModel.lightValue > viewModel.minLightValue
            },
            set: {
                viewModel.lightValue = $0 ? viewModel.initLightValue : viewModel.minLightValue
            }
        )
    }
    
    @ViewBuilder
    private var controls: some View {
        VStack {
            Slider(value: $viewModel.lightValue, in: (viewModel.minLightValue...viewModel.maxLightValue))
            
            HStack {
                Toggle(isOn: lightIsOn) {
                    Image(systemName: "lightbulb")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .symbolVariant(lightIsOn.wrappedValue ? .fill : .none)
                        .contentTransition(.symbolEffect(.replace))
                        .symbolEffect(.variableColor, value: lightIsOn.wrappedValue)
                }
                .toggleStyle(.button)
                .frame(width: 24, height: 24)
                .padding()
                .rotationEffect(.degrees(90))
                
                Toggle(isOn: $viewModel.lightInheritsRotation) {
                    Image(systemName: "parkinglight")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .symbolVariant(viewModel.lightInheritsRotation ? .fill : .none)
                        .contentTransition(.symbolEffect(.replace))
                        .symbolEffect(.variableColor, value: viewModel.lightInheritsRotation)
                }
                .toggleStyle(.button)
                .frame(width: 24, height: 24)
                .padding()
                .rotationEffect(.degrees(90))
                
                Picker("", selection: $viewModel.lightType) {
                    ForEach(PortalViewModel.LightType.allCases) { item in
                        Text(item.resource)
                            .tag(item.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .padding()
        .frame(width: 320)
        .glassBackgroundEffect()
        .rotationEffect(.degrees(270))
    }
    
    var body: some View {
        RealityView { content, _ in
            let portalContent = viewModel.makePortalContent()
            let portal = viewModel.makePortal(content: portalContent)
            
            let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2(1, 1)), trackingMode: .continuous)
            
            wallAnchor.addChild(portalContent)
            wallAnchor.addChild(portal)
            
            content.add(wallAnchor)
            
        } update: { content, attachments in
            if let portalContent = viewModel.portalContent,
               let light = viewModel.lightComponent {
                portalContent.components[ImageBasedLightComponent.self] = light
            }
            
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
    PortalView()
}
