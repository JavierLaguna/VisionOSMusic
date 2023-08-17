import RealityKit

// Ensure you register this component in your app’s delegate using:
// DrumKitPieceComponent.registerComponent()
public struct DrumKitPieceComponent: Component, Codable {
    // Name used to uniquely identify the component type. It can differ from the struct name.
    public static var componentName: String { "RealityKitContent.DrumKitPieceComponent" }

    public var type: PieceType = .kick

    public init() {}
}

extension DrumKitPieceComponent {
    
    public enum PieceType: String, Codable {
        case kick
        case snare
        case cymbal
    }
}
