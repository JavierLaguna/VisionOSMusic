import RealityKit

// Ensure you register this component in your app’s delegate using:
// BillboardComponent.registerComponent()
public struct BillboardComponent: Component, Codable {
    // Name used to uniquely identify the component type. It can differ from the struct name.
    public static var componentName: String { "RealityKitContent.BillboardComponent" }

    public init() {
        // Intentional empty
    }
}
