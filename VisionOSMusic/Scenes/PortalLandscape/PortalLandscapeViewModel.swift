
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
        portal.components[ModelComponent.self] = .init(
            mesh: .generatePlane(width: 1.5, height: 1.5, cornerRadius: 0),
            materials: [PortalMaterial()]
        )
        
        let portalComponent = PortalComponent(target: content)
        portal.components[PortalComponent.self] = portalComponent
    
        return portal
    }
    
    func makePortalContent() -> Entity {
        let content = Entity()
        content.components[WorldComponent.self] = .init()
        let backgroundEntity = ImmersiveViewBackgroundEntity(imageResource: immersiveBg.resource)
        
        self.backgroundEntity = backgroundEntity
        
        content.addChild(backgroundEntity)
                
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
