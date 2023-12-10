
import SwiftUI
import RealityKit
import RealityKitContent

public class ParticleTransitionSystem: System {
    private static let query = EntityQuery(where: .has(ParticleEmitterComponent.self))
    
    required public init(scene: RealityKit.Scene) {
        setUpSession()
    }
    
    func setUpSession() {
        // ??
    }

    public func update(context: SceneUpdateContext) {
        let entities = context.scene.performQuery(Self.query)
        for entity in entities {
            updateParticles(entity: entity)
        }
    }
}

public func updateParticles(entity: Entity) {
    guard var particle = entity.components[ParticleEmitterComponent.self] else {
        return
    }

    let scale = max(entity.scale(relativeTo: nil).x, 0.3)

    let vortexStrength: Float = 2.0
    let lifeSpan: Float = 1.0
    particle.mainEmitter.vortexStrength = scale * vortexStrength
    particle.mainEmitter.lifeSpan = Double(scale * lifeSpan)

    entity.components[ParticleEmitterComponent.self] = particle
}
