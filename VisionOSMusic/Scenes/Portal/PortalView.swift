
import SwiftUI
import RealityKit
import RealityKitContent

struct PortalView: View {
    
    @State var planeEntity: Entity = {
        let wallAnchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2(1, 1)))
        let planeMesh = MeshResource.generatePlane(width: 3.75, depth: 2.625, cornerRadius: 0.1)
        
        let material = PostersView.loadImageMaterial(imageUrl: "playlist_rap")
        
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
        planeEntity.name = "canvas"
        wallAnchor.addChild(planeEntity)
        
        let world = makeWorld()
        let portal = makePortal(world: world)
        
        //        portal.scale *= .init(x: 1, y: 1, z: -1)
        //        portal.transform.rotation = simd_quatf(angle: .pi, axis: SIMD3(0.0, 1.0, 0.0))
        
        
        wallAnchor.addChild(world)
        wallAnchor.addChild(portal)
        
        return wallAnchor
    }()
    
    static func makePortal(world: Entity) -> Entity {
        let portal = Entity()
        
        portal.components[ModelComponent.self] = .init(mesh: .generatePlane(width: 1,
                                                                            height: 1,
                                                                            cornerRadius: 0.5),
                                                       materials: [PortalMaterial()])
        let portalComponent = PortalComponent(target: world)
        
        portal.components[PortalComponent.self] = portalComponent
        
        return portal
    }
    
    static func makeWorld() -> Entity {
        let world = Entity()
        world.components[WorldComponent.self] = .init()
        
        let environment = try! EnvironmentResource.load(named: Scene3D.Component.toplight)
//        world.components[ImageBasedLightComponent.self] = .init(source: .single(environment), intensityExponent: 50)
        
        var aa = ImageBasedLightComponent(source: .single(environment), intensityExponent: 10)
//        aa.inheritsRotation = true
        world.components[ImageBasedLightComponent.self] = aa
        
        world.components[ImageBasedLightReceiverComponent.self] = .init(imageBasedLight: world)
        
        let rootEntity = try! ModelEntity.load(named: Scene3D.fender, in: realityKitContentBundle)
        rootEntity.position = SIMD3<Float>(x: 0, y: -0.5, z: -1)
        world.addChild(rootEntity)
        
        return world
    }
    
    var body: some View {
        RealityView { content in
            
            let world = PortalView.makeWorld()
            let portal = PortalView.makePortal(world: world)
            
            let anchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2(1, 1)))
            content.add(world)
            content.add(portal)
            
            
            content.add(anchor)
            anchor.addChild(portal)
            
            content.add(planeEntity)
        }
    }
}

#Preview {
    PortalView()
}
