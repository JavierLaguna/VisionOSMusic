
import Observation
import RealityKit
import RealityKitContent

@Observable
final class PortalViewModel {
    
    let minLightValue: Float = 10
    let initLightValue: Float = 13
    let maxLightValue: Float = 16
    
    var portalContent: Entity?
    var lightComponent: ImageBasedLightComponent?
    var lightValue: Float = 13 {
        didSet {
            lightComponent?.intensityExponent = lightValue
        }
    }
    var lightInheritsRotation = false {
        didSet {
            lightComponent?.inheritsRotation = lightInheritsRotation
        }
    }
    
    init() {
        loadResources()
    }
    
    func makePortal(content: Entity) -> Entity {
        let portal = Entity()
        portal.components[ModelComponent.self] = .init(
            mesh: .generatePlane(width: 1, height: 1, cornerRadius: 0.5),
            materials: [PortalMaterial()]
        )
        
        let portalComponent = PortalComponent(target: content)
        portal.components[PortalComponent.self] = portalComponent
    
        return portal
    }
    
    func makePortalContent() -> Entity {
        let content = Entity()
        content.components[WorldComponent.self] = .init()
        
        let rootEntity = try! ModelEntity.load(named: Scene3D.fender, in: realityKitContentBundle)
        rootEntity.position = SIMD3<Float>(x: 0, y: -0.5, z: -1)
        content.addChild(rootEntity)
        
        content.components[ImageBasedLightReceiverComponent.self] = .init(imageBasedLight: content)
        
        if let lightComponent {
            content.components[ImageBasedLightComponent.self] = lightComponent
        }
        
        portalContent = content
        
        return content
    }
}

// MARK: Private methods
private extension PortalViewModel {
    
    func loadResources() {
        guard let topLightResource = try? EnvironmentResource.load(named: Scene3D.Component.topLight) else {
            return
        }
        
        var lightComponent = ImageBasedLightComponent(source: .single(topLightResource), intensityExponent: lightValue)
        lightComponent.inheritsRotation = lightInheritsRotation
        self.lightComponent = lightComponent
    }
}
