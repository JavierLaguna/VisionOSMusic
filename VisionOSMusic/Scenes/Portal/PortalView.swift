
import SwiftUI
import RealityKit
import RealityKitContent

struct PortalView: View {
    
    func makePortal(content: Entity) -> Entity {
        let portal = Entity()
        
        portal.components[ModelComponent.self] = .init(mesh: .generatePlane(width: 1,
                                                                            height: 1,
                                                                            cornerRadius: 0.5),
                                                       materials: [PortalMaterial()])
        let portalComponent = PortalComponent(target: content)
        
        portal.components[PortalComponent.self] = portalComponent
        
        return portal
    }
    
    func makePortalContent() -> Entity {
        let content = Entity()
        content.components[WorldComponent.self] = .init()
        
        if let topLightResource = try? EnvironmentResource.load(named: Scene3D.Component.topLight) {
            
            var topLight = ImageBasedLightComponent(source: .single(topLightResource), intensityExponent: 10)
            topLight.inheritsRotation = true
            
            content.components[ImageBasedLightComponent.self] = topLight
            content.components[ImageBasedLightReceiverComponent.self] = .init(imageBasedLight: content)
        }
        
        let rootEntity = try! ModelEntity.load(named: Scene3D.fender, in: realityKitContentBundle)
        rootEntity.position = SIMD3<Float>(x: 0, y: -0.5, z: -1)
        content.addChild(rootEntity)
        
        return content
    }
    
    var body: some View {
        RealityView { content in
            
            let content = makePortalContent()
            let portal = makePortal(content: content)
            
            let wallAnchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2(1, 1)))
            
            
            let planeMesh = MeshResource.generatePlane(width: 3.75, depth: 2.625, cornerRadius: 0.1)
            
            let material = PostersView.loadImageMaterial(imageUrl: "playlist_rap")
            
            let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
            planeEntity.name = "canvas"
            wallAnchor.addChild(planeEntity)
            
            
            content.add(content)
            content.add(portal)
            
            
            content.add(wallAnchor)
            wallAnchor.addChild(portal)
        }
    }
}

#Preview {
    PortalView()
}
