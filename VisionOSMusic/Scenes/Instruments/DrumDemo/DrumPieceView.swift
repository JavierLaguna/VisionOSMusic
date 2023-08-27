
import SwiftUI
import RealityKitContent

struct DrumPieceView: View {
    
    let type: DrumKitPieceComponent.PieceType
    let onPressPlayButton: () -> Void
    
    @State private var isExpanded = false
    
    var body: some View {
        Group {
            if isExpanded {
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
            } else {
                HStack {
                    Image("snare_image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    Text("Snare")
                        .font(.title)
                    
                    Spacer()
                    
                    Image(systemName: "rectangle.arrowtriangle.2.outward")
                        .resizable()
                        .frame(width: 40, height: 40)
//                    Image(systemName: "rectangle.arrowtriangle.2.inward")
                }
                .padding(.top, 8)
                .padding(.horizontal, 4)
            }
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
