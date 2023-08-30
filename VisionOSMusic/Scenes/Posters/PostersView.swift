
import SwiftUI
import RealityKit
import RealityKitContent

struct PostersView: View {
    
    private let lists = ["playlist_techno", "playlist_rock", "playlist_pop"]
    
    @State var planeEntity: Entity = {
        let wallAnchor = AnchorEntity(.plane(.horizontal, classification: .seat, minimumBounds: SIMD2(0.1, 0.1)))
        let planeMesh = MeshResource.generatePlane(width: 0.5, depth: 2.625, cornerRadius: 0.1)
        
        let material = PostersView.loadImageMaterial(imageUrl: "playlist_rap")
        let material2 = SimpleMaterial(color: .green, isMetallic: false)
        
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
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
            var entity = getWall(list: $0)
            
            while entities.contains(entity) {
                entity = getWall(list: $0)
            }
            
            entities.append(entity)
        }
        
        return entities
    }
    
    private func getWall(list: String) -> Entity {
        let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2(0.8, 0.8)))
//        let planeMesh = MeshResource.generatePlane(width: 2.75, depth: 2.625, cornerRadius: 0.1)
        let planeMesh = MeshResource.generatePlane(width: 3.75, depth: 0.5, cornerRadius: 0.1)
        
        let material = PostersView.loadImageMaterial(imageUrl: list)
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
        
        planeEntity.name = "planeEntity-\(list)"
        wallAnchor.name = "wall-\(list)"
        wallAnchor.addChild(planeEntity)
        return wallAnchor
    }
    
    var body: some View {
        RealityView { content, _ in
            
            content.add(planeEntity)
            
            generate().forEach {
                content.add($0)
            }
            
        } update: { content, attachments in
            
//            generate().forEach {
//                content.add($0)
//            }
            
        } attachments: {
            
        }
        .gesture(TapGesture().targetedToAnyEntity().onEnded({ entity in
            var transform = entity.entity.transform
            transform.translation = SIMD3(0.1, 0, -0.1)
            entity.entity.move(
                to: transform,
                relativeTo: nil,
                duration: 3,
                timingFunction: .easeInOut
            )
            
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
        }))
    }
}

#Preview {
    PostersView()
}
