
import SwiftUI
import RealityKit
import RealityKitContent

struct PortalView: View {
    
    @State var planeEntity: Entity = {
        let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2(1, 1)))
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
        
        let rootEntity = try! ModelEntity.load(named: Scene3D.snareDrum, in: realityKitContentBundle)
        world.addChild(rootEntity)
        
        return world
    }
    
    var body: some View {
        RealityView { content in
            
//                let world = makeWorld()
//                let portal = makePortal(world: world)
            
                let anchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2(1, 1)))
//            content.add(world)
//            content.add(portal)
            

//                content.add(anchor)
//                        anchor.addChild(makePortal(world: makeWorld()))
            
            content.add(planeEntity)
        }
    }
}

#Preview {
    PortalView()
}
