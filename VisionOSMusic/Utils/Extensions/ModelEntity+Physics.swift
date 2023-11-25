
import RealityKit

extension ModelEntity {
    
    func setPhysicsComponent(mode: PhysicsBodyMode, inertia: Float = 10, mass: Float = 1) async {
        
        if let collisionShape = model?.mesh {
            components[CollisionComponent.self] = try? await .init(shapes: [.generateConvex(from: collisionShape)])
        }

        if mode == .static {
            components[PhysicsBodyComponent.self] = .init(massProperties: .default, material: nil, mode: .static)
            
        } else if mode == .dynamic {
            components[PhysicsBodyComponent.self] = .init(
                massProperties: .init(mass: mass, inertia: .one * inertia),
                material: nil,
                mode: .dynamic
            )
        }
    }
}
