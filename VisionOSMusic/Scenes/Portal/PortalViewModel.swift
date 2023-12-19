
import Observation
import RealityKit
import RealityKitContent

@Observable
final class PortalViewModel {
    
    let minLightValue: Float = 0
    let initLightValue: Float = 8
    let maxLightValue: Float = 16
    
    var portalContent: Entity?
    var lightComponent: ImageBasedLightComponent?
    var lightValue: Float = 8 {
        didSet {
            lightComponent?.intensityExponent = lightValue
        }
    }
    var lightInheritsRotation = false {
        didSet {
            lightComponent?.inheritsRotation = lightInheritsRotation
        }
    }
    var lightType: LightType = .top {
        didSet {
            loadLightComponent()
        }
    }
    
    init() {
        loadLightComponent()
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
        
        guard let rootEntity = try? ModelEntity.load(named: Scene3D.fender, in: realityKitContentBundle) else {
            return content
        }
        
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
    
    func loadLightComponent() {
        guard let topLightResource = try? EnvironmentResource.load(named: lightType.resource) else {
            return
        }
        
        var lightComponent = ImageBasedLightComponent(source: .single(topLightResource), intensityExponent: lightValue)
        lightComponent.inheritsRotation = lightInheritsRotation
        self.lightComponent = lightComponent
    }
}

// MARK: LightType
extension PortalViewModel {
 
    enum LightType: String, Identifiable, CaseIterable {
        case top
        case sun
        case ibl
        
        var id: Self { self }
        
        var resource: String {
            switch self {
            case .top: Scene3D.Component.topLight
            case .sun: Scene3D.Component.sunlight
            case .ibl: Scene3D.Component.ibl
            }
        }
    }
}
