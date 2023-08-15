
enum Instrument: String, CaseIterable, Identifiable {
    case drums
    case guitar
    case violin
    
    var id: Self { self }
}

extension Instrument {
    
    var name: String {
        switch self {
        case .drums: "Drums"
        case .guitar: "Guitar"
        case .violin: "Violin"
        }
    }
    
    var scene: String {
        switch self {
        case .drums: Scene3D.drums
        case .guitar: Scene3D.guitar
        case .violin: Scene3D.violin
        }
    }
    
    var sceneOrientation: SIMD3<Double> {
        switch self {
        case .drums: [0, 0, 0]
        case .guitar: [0.25, 0, 0.75]
        case .violin: [0.5, 0.5, 0]
        }
    }
    
    var canRotate: Bool {
        self == .drums
    }
    
    var hasDemo: Bool {
        self == .drums
    }
}
