
import SwiftUI
import RealityKit

final class ImmersiveViewBackgroundEntity: Entity {
    
    private(set) var imageResource: String
    
    init(imageResource: String) {
        self.imageResource = imageResource
        super.init()
        
        loadResource()
        setScale()
    }
    
    required init() {
        imageResource = ""
    }
    
    func update(imageResource: String) {
        guard self.imageResource != imageResource else {
            return
        }
        
        self.imageResource = imageResource
        loadResource()
    }
}

// MARK: Private methods
private extension ImmersiveViewBackgroundEntity {
    
    func loadResource() {
        Task {
            guard let resource = try? await TextureResource(named: imageResource) else {
                
                print("Unable to load \(imageResource) texture.")
                return
            }
            
            var material = UnlitMaterial()
            material.color = .init(texture: .init(resource))
            
            components.set(ModelComponent(
                mesh: .generateSphere(radius: 1000),
                materials: [material]
            ))
        }
    }
    
    func setScale() {
        scale *= .init(x: -1, y: 1, z: 1)
    }
}

#Preview {
    RealityView { content in
        content.add(ImmersiveViewBackgroundEntity(imageResource: ImmersiveBackgroundScene.starfield.resource))
    }
}
