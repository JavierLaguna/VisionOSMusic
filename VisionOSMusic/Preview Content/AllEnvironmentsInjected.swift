
import SwiftUI

extension View {
    
    var allEnvironmentsInjected: some View {
        self.modifier(
            AllEnvironmentsInjectedModifier()
        )
    }
}

private struct AllEnvironmentsInjectedModifier: ViewModifier {
    
    @State private var coordinator = PlaylistsCoordinator()
    
    func body(content: Content) -> some View {
        content
            .environment(MainViewModel())
            .environment(MainCoordinator())
            .environment(PlaylistsCoordinator())
    }
}
