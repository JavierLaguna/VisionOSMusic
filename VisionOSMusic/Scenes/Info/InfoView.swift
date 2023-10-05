
import SwiftUI

struct InfoView: View {
    
    private let onPressClose: () -> Void
    
    init(onPressClose: @escaping () -> Void) {
        self.onPressClose = onPressClose
    }
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Spacer()
                
                Button(action: onPressClose, label: {
                    Image(systemName: "xmark.circle.fill")
                })
            }
            
            Text(" VisionOS Music")
                .font(.extraLargeTitle)
            
            Text("My first xrOS App!")
                .font(.body)
            
            Text("👨🏻‍💻 Javier Laguna 📱")
                .font(.caption)
        }
        .padding(32)
    }
}

#Preview {
    InfoView() {}
}
