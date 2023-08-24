import RealityKit

// Ensure you register this component in your app’s delegate using:
// DrumKitPieceComponent.registerComponent()
public struct DrumKitPieceComponent: Component, Codable {
    // Name used to uniquely identify the component type. It can differ from the struct name.
    public static var componentName: String { "RealityKitContent.DrumKitPieceComponent" }

    public var type: PieceType = .kick

    public init() {}
}

// MARK: PieceType
extension DrumKitPieceComponent {
    
    public enum PieceType: String, Codable, CaseIterable {
        case kick
        case snare
        case cymbal
        
        public var soundPath: String {
            switch self {
            case .kick: "/Root/kick_wav"
            case .snare: "/Root/snare_wav"
            case .cymbal: "/Root/crash_wav"
            }
        }
    }
}
