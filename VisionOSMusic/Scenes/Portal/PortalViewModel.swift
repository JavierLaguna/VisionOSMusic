
import Observation
import RealityKit
import RealityKitContent

@Observable
final class PortalViewModel {
    
    private var topLightResource: EnvironmentResource?
    
    var portalContent: Entity?
    var lightOn = false
    var lightValue: Float = 20
    
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
        
        if let light = getLight() {
            content.components[ImageBasedLightComponent.self] = light
        }
        
        portalContent = content
        
        return content
    }
    
    func getLight() -> ImageBasedLightComponent? {
        
        guard let topLightResource else {
            return nil
        }
        
        return ImageBasedLightComponent(source: .single(topLightResource), intensityExponent: lightOn ? 30 : 10)
    }
}

// MARK: Private methods
private extension PortalViewModel {
    
    func loadResources() {
        topLightResource = try? EnvironmentResource.load(named: Scene3D.Component.topLight)
    }
}
