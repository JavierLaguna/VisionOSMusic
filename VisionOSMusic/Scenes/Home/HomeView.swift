
import SwiftUI

struct HomeView: View {
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    private func toggleDemo() {
        Task {
            await openImmersiveSpace(id: WindowName.posters)
            
        }
    }
    
    var body: some View {
        VStack {
            Text("TODO: HomeView")
            
            Button("OPEN", action: toggleDemo)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environment(MainViewModel())
}
