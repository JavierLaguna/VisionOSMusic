
import Observation
import RealityKit
import RealityKitContent

@Observable
final class PortalLandscapeViewModel {
    
    private(set) var immersiveBg: ImmersiveBackgroundScene = BusinessConstants.DefaultValues.favoriteImmersiveBg {
        didSet {
            backgroundEntity?.update(imageResource: immersiveBg.resource)
        }
    }
    private(set) var backgroundEntity: ImmersiveViewBackgroundEntity?
    
    func makePortal(content: Entity) -> Entity {
        let portal = Entity()
        portal.orientation = simd_quatf(angle: -.pi / 2, axis: [1, 0, 0])
        portal.components[ModelComponent.self] = .init(
            mesh: .generatePlane(width: 4, height: 2, cornerRadius: 0),
            materials: [PortalMaterial()]
        )
        
        let portalComponent = PortalComponent(target: content)
        portal.components[PortalComponent.self] = portalComponent
    
        return portal
    }
    
    func makePortalContent() -> Entity {
        let content = Entity()
        content.components[WorldComponent.self] = .init()
        content.orientation = simd_quatf(angle: -.pi / 2, axis: [1, 0, 0])
        backgroundEntity = ImmersiveViewBackgroundEntity(imageResource: immersiveBg.resource)
        
        if let backgroundEntity {
            content.addChild(backgroundEntity)
        }
                
        return content
    }
    
    func randomImmersiveBg() {
        guard let newBg = ImmersiveBackgroundScene.allCases.randomElement() else {
            return
        }
        
        if immersiveBg == newBg {
            randomImmersiveBg()
        } else {
            immersiveBg = newBg
        }
    }
}
