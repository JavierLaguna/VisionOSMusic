
import RealityKit

extension Entity {
    
    var modelComponent: ModelComponent? {
        components[ModelComponent.self]
    }
    
    var shaderGraphMaterial: ShaderGraphMaterial? {
        modelComponent?.materials.first as? ShaderGraphMaterial
    }
    
    var parameterNames: [String]? {
        shaderGraphMaterial?.parameterNames
    }
    
    func hasMaterialParameter(named: String) -> Bool {
        parameterNames?.contains(where: { $0 == named }) ?? false
    }
}
