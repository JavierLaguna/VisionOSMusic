
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
    @State private var updateCubeFace = false
    
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
            
            await entity.components.set(HoverEffectComponent())
            await entity.components.set(InputTargetComponent())
            await entity.setModelMeshCollisionComponent()
        }
        
        return entity
    }
    
    private func addPhysicsToCube() async {
        guard let cube else { return }
        
        await cube.setPhysicsComponent(mode: .dynamic, inertia: 20, mass: 10)
        await cube.components.set(PhysicsMotionComponent())
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
            
            await addPhysicsToCube()
        }
    }
    
    private func onChangeCubeDrag(value: EntityTargetValue<DragGesture.Value>) {
        guard let cube,
              let cubeParent = cube.parent else {
            return
        }
        
        cube.resetPhysicsComponent()
        
        cube.position = value.convert(value.location3D, from: .local, to: cubeParent)
    }
    
    private func onEndCubeDrag() {
        updateCubeFace = true
        
        Task {
            await addPhysicsToCube()
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
            
            let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                // TODO: JLI listen only when cube stopped
                
                guard 
//                    updateCubeFace,
                      let cubeMotion = cube.components[PhysicsMotionComponent.self] else {
                    return
                }
                
                if simd_length(cubeMotion.linearVelocity) < 0.1 && simd_length(cubeMotion.angularVelocity) < 0.1 {
                    let xDirection = cube.convert(direction: SIMD3(x: 1, y: 0, z: 0), to: nil)
                    let yDirection = cube.convert(direction: SIMD3(x: 0, y: 1, z: 0), to: nil)
                    let zDirection = cube.convert(direction: SIMD3(x: 0, y: 0, z: 1), to: nil)
                    
                    let greatestDirection = [
                        0: xDirection.y,
                        1: yDirection.y,
                        2: zDirection.y
                    ].sorted(by: { abs($0.1) > abs($1.1) }).first! // TODO: JLO
                    print("xDirection", xDirection)
                    print("yDirection", yDirection)
                    print("zDirection", zDirection)
                    print("greatestDirection", greatestDirection)
                    
//                    let facesChunked = cubeFaces.chunked(into: 2)
                    
//                    private let cubeFaces = [
//                        "playlist_rock",
//                        "playlist_rap",
//                        "playlist_techno",
//                        "playlist_funk",
//                        "playlist_blues",
//                        "playlist_pop"
//                    ]
                    
                    let facesChunked = [
                        ["playlist_rap", "playlist_funk"],
                        ["playlist_pop", "playlist_blues"],
                        ["playlist_rock", "playlist_techno"],
                        
                    ]
                    
                    let topFace = facesChunked[greatestDirection.key][greatestDirection.value > 0 ? 0 : 1]
                    print("TOP FACE", topFace)
                    
                    updateCubeFace = false
                }
            }
        }
        .gesture(
            SpatialTapGesture()
            //  .targetedToEntity(cube)
                .targetedToAnyEntity()
                .onEnded { value in
                    if value.entity.name == cubeName {
                        onTapCube()
                    }
                }
        )
        .gesture(
            DragGesture()
            //  .targetedToEntity(cube)
                .targetedToAnyEntity()
                .onChanged { value in
                    if value.entity.name == cubeName {
                        onChangeCubeDrag(value: value)
                    }
                }
                .onEnded { value in
                    if value.entity.name == cubeName {
                        onEndCubeDrag()
                    }
                }
        )
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

#Preview {
    CubeView()
}
