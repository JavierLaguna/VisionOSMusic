
import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ProgressView()
            .tint(.accent)
    }
}

#Preview {
    LoadingView()
        .previewLayout(.sizeThatFits)
}
