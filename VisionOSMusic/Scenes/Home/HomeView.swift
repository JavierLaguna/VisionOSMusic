
import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            Text("TODO: HomeView")
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environment(MainViewModel())
}
