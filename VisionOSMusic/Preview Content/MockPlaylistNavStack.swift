
import SwiftUI

extension View {
    
    var mockPlaylistNavStacked: some View {
        self.modifier(
            MockPlaylistNavStackModifier()
        )
    }
}

private struct MockPlaylistNavStackModifier: ViewModifier {
    
    @State private var coordinator = PlaylistsCoordinator()
    
    func body(content: Content) -> some View {
        NavigationStack(path: $coordinator.path) {
            content
                .navigationDestination(for: PlaylistsCoordinator.Routes.self) { $0 }
        }
        .environment(MainViewModel())
        .environment(coordinator)
    }
}
