
import SwiftUI

extension NavigationLink {
    
    var plainNavLink: some View {
        self.modifier(
            PlainNavLinkModifier()
        )
    }
}

private struct PlainNavLinkModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.plain)
    }
}
