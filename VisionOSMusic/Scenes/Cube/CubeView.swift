
import SwiftUI
import RealityKit

struct CubeView: View {
    
    private let cubeName = "CubeEntity"
    private let cubeFaces = [
        "playlist_rock",
        "playlist_rap",
        "playlist_techno",
        "playlist_funk",
        "playlist_blues",
        "playlist_pop"
    ]
    
    @State private var root: Entity?
    @State private var cube: ModelEntity?
    
    private func makeFloor() -> Entity {
        let entity = Entity()
        entity.position = [0, -0.1, 0]
        entity.components[PhysicsBodyComponent.self] = .init(massProperties: .default, material: nil, mode: .static)
        entity.components[CollisionComponent.self] = .init(shapes: [.generateBox(width: 30, height: 0.2, depth: 30)])
        
        return entity
    }
    
    private func makeCube() async -> ModelEntity {
        
        let materials: [SimpleMaterial]? = try? await withThrowingTaskGroup(of: SimpleMaterial?.self) { group in
            return try await withThrowingTaskGroup(of: SimpleMaterial?.self) { group in
                
                for assetName in cubeFaces {
                    group.addTask {
                        do {
                            let texture = try await TextureResource(named: assetName)
                            var material = SimpleMaterial()
                            material.color = .init(texture: .init(texture))

                            return material
                            
                        } catch {
                            return nil
                        }
                    }
                }
                
                return try await group.reduce(into: [SimpleMaterial]()) { materials, material in
                    if let material = material {
                        materials.append(material)
                    }
                }
            }
        }
        
        let entity = await ModelEntity()
        
        if let materials {
            await entity.components.set(ModelComponent(
                mesh: .generateBox(width: 0.5, height: 0.5, depth: 0.5, splitFaces: true),
                materials: materials)
            )
            
            await entity.components.set(InputTargetComponent())
            await entity.setModelMeshCollisionComponent()
        }
                
        return entity
    }
    
    private func onTapCube() {
        guard let cube else { return }
        
        cube.resetPhysicsComponent()
        
        Task {
            let destTransform = await Transform(
                scale: cube.scale,
                rotation: simd_quatf(
                    angle: 0,
                    axis: [0, 1, 1]
                ),
                translation: [0, 3, -2.5]
            )
                        
            await cube.move(to: destTransform, relativeTo: root, duration: 2)
            
            try? await Task.sleep(for: .seconds(2.2))
            
            await cube.setPhysicsComponent(
                mode: .dynamic,
                inertia: 20,
                mass: 10
            )
        }
    }
    
    var body: some View {
        RealityView { content in
            let root = Entity()
            
            let floor = makeFloor()
            root.addChild(floor)
            
            let cube = await makeCube()
            cube.name = cubeName
            cube.position = [-1, 1, -2]
            // entity.scale = .one * 1.5
            cube.components[GroundingShadowComponent.self] = .init(castsShadow: true)
            self.cube = cube
            root.addChild(cube)
            
            content.add(root)
        }
        .gesture(
            SpatialTapGesture()
//                .targetedToEntity(cube)
                .targetedToAnyEntity()
                .onEnded { value in
                    if value.entity.name == cubeName {
                        onTapCube()
                    }
                }
        )
    }
}

#Preview {
    CubeView()
}
