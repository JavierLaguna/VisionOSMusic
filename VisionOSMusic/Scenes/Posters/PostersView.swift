
import SwiftUI
import RealityKit
import RealityKitContent

struct PostersView: View {
    
    let lists = ["playlist_techno", "playlist_rock", "playlist_pop"]
    
    @State var planeEntity: Entity = {
        let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2(0.8, 0.8)))
        let planeMesh = MeshResource.generatePlane(width: 3.75, depth: 2.625, cornerRadius: 0.1)
        
        let material = PostersView.loadImageMaterial(imageUrl: "playlist_techno")
        let material2 = PostersView.loadImageMaterial(imageUrl: "playlist_rock")
        let material3 = SimpleMaterial(color: .green, isMetallic: false)
        
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material, material2, material3])
        planeEntity.name = "canvas"
        wallAnchor.addChild(planeEntity)
        return wallAnchor
    }()
    
    static func loadImageMaterial(imageUrl: String) -> SimpleMaterial {
        do {
            let texture = try TextureResource.load(named: imageUrl)
            var material = SimpleMaterial()
            let color = SimpleMaterial.BaseColor(texture: MaterialParameters.Texture(texture))
            material.color = color
            return material
            
        } catch {
            fatalError("Failed to load a model asset.")
        }
    }
    
    private func generate() -> [Entity] {
        var entities: [Entity] = []
        
        lists.forEach {
            var tries = 0
            var entity = getWall(list: $0)
            while tries >= 5 || !entities.contains(entity) {
                print("BUCLE!")
                tries += 1
                entity = getWall(list: $0)
            }
            
            entities.append(entity)
        }
        
        return entities
    }
    
    private func getWall(list: String) -> Entity {
        let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2(0.8, 0.8)))
        let planeMesh = MeshResource.generatePlane(width: 0.75, depth: 2.625, cornerRadius: 0.1)
//        let material = SimpleMaterial(color: .green, isMetallic: false)
        let material = PostersView.loadImageMaterial(imageUrl: list)
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
        planeEntity.name = "planeEntity-\(list)"
        wallAnchor.name = "wall-\(list)"
        wallAnchor.addChild(planeEntity)
        return wallAnchor
    }
        
    var body: some View {
        RealityView { content, _ in
            do {
//                let rootEntity = try await Entity(named: Scene3D.emptyScene, in: realityKitContentBundle)
//                content.add(rootEntity)
                
                generate().forEach {
                    content.add($0)
                }
                
//                content.add(planeEntity)
                
            } catch {
                fatalError("Failed to load a model asset.")
            }
            
        } update: { content, attachments in
            
            
        } attachments: {
            
        }
        //        .gesture(TapGesture().targetedToAnyEntity().onEnded({ entity in
        //            var transform = entity.entity.transform
        //            transform.translation = SIMD3(0.1, 0, -0.1)
        //            entity.entity.move(
        //                to: transform,
        //                relativeTo: nil,
        //                duration: 3,
        //                timingFunction: .easeInOut
        //            )
        
        //            let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
        //                var transform = entity.entity.transform
        //                let radians = 90.0 * Float.pi / 100.0
        //                transform.rotation *= simd_quatf(angle: radians, axis: SIMD3(0.0, 0.0, 1.0))
        //
        //                entity.entity.move(
        //                    to: transform,
        //                    relativeTo: nil,
        //                    duration: 3,
        //                    timingFunction: .easeInOut
        //                )
        //            }
        //
        //            timer.fire()
        //        }))
    }
}

#Preview {
    PostersView()
}
