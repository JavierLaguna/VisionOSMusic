
import SwiftUI
import RealityKitContent

struct DrumPieceView: View {
    
    let type: DrumKitPieceComponent.PieceType
    let onPressPlayButton: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("snare_image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
                Text("Snare")
                    .font(.title)
            }
            .padding(.top, 8)
            .padding(.horizontal, 4)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                .padding()
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 12))
            
            Button("Play", action: onPressPlayButton)
        }
        .padding()
        .padding(.bottom, 12)
        .frame(width: 300)
        .glassBackgroundEffect()
    }
}

#Preview {
    DrumPieceView(type: .snare) {
        print("Play pressed")
    }
    .previewLayout(.sizeThatFits)
}
