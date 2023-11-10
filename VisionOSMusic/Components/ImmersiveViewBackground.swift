
import SwiftUI
import RealityKit

final class ImmersiveViewBackground: Entity {
    
    private let imageResource: String
    
    init(imageResource: String) {
        self.imageResource = imageResource
        super.init()
        
        loadResource()
    }
    
    required init() {
        imageResource = ""
    }
    
    private func loadResource() {
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
            
            scale *= .init(x: -1, y: 1, z: 1)
        }
    }
}

#Preview {
    RealityView { content in
        content.add(ImmersiveViewBackground(imageResource: "starfield_bg_scene"))
    }
}
