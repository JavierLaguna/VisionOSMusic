
enum ImmersiveBackgroundScene: String, CaseIterable, Equatable, Identifiable {
    case starfield
    case beach
    case barcelona
    case camping
    case creek
    case hillside
    case lake
    case ocean
    case park
    
    var id: Self { self }
    
    var title: String {
        rawValue.capitalized
    }
    
    var resource: String {
        "\(rawValue)_bg_scene"
    }
}
