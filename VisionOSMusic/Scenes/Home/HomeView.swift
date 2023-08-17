
import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            Text("TODO: HomeView")
            
//            DrumDemo()
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environment(MainViewModel())
}
