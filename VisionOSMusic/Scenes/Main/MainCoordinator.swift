
import Observation
import SwiftUI

@Observable
final class MainCoordinator {
    
    var tabSelection: Int = 0
    var tabSelectionBinding: Binding<Int> {
        Binding(
            get: { self.tabSelection },
            set: { self.tabSelection = $0 }
        )
    }
    
    func navigateToPlaylist() {
        tabSelection = 1
    }
    
    func navigateToInstruments() {
        tabSelection = 2
    }
    
    func navigateToSettingsTab() {
        tabSelection = 3
    }
}
