
import SwiftUI

extension View {
    
    func isVisible(when visible: Bool) -> some View {
        self.opacity(visible ? 1 : 0)
    }
    
    
    func isHidden(when notVisible: Bool) -> some View {
        self.opacity(notVisible ? 0 : 1)
    }
}
