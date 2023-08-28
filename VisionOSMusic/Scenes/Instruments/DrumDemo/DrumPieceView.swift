
import SwiftUI
import RealityKitContent

struct DrumPieceView: View {
    
    let type: DrumKitPieceComponent.PieceType
    let onPressPlayButton: () -> Void
    
    @Namespace private var animationSpace
    @State private var isExpanded = false
    
    private func changeExpandedState() {
        withAnimation(.easeInOut) {
            isExpanded.toggle()
        }
    }
    
    @ViewBuilder
    private var closedView: some View {
        HStack {
            Image(type.image)
                .resizable()
                .scaledToFit()
                .matchedGeometryEffect(id: "Image", in: animationSpace)
                .clipShape(.rect(cornerRadius: 12))
                .frame(width: 60, height: 60)
            
            Text(type.name)
                .matchedGeometryEffect(id: "Name", in: animationSpace)
                .font(.title2)
            
            Spacer()
            
            Button(action: changeExpandedState, label: {
                Image(systemName: "rectangle.arrowtriangle.2.outward")
                    .resizable()
                    .frame(width: 32, height: 32)
            })
            .matchedGeometryEffect(id: "ToogleIcon", in: animationSpace)
        }
        .padding(.top, 8)
        .padding(.horizontal, 4)
    }
    
    @ViewBuilder
    private var expandedView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(type.name)
                    .matchedGeometryEffect(id: "Name", in: animationSpace)
                    .font(.title)
                
                Spacer()
                
                Button(action: changeExpandedState, label: {
                    Image(systemName: "rectangle.arrowtriangle.2.inward")
                        .resizable()
                        .frame(width: 32, height: 32)
                })
                .matchedGeometryEffect(id: "ToogleIcon", in: animationSpace)
            }
            .padding(.top, 8)
            .padding(.horizontal, 4)
            
            Image(type.image)
                .resizable()
                .scaledToFit()
                .matchedGeometryEffect(id: "Image", in: animationSpace)
                .clipShape(.rect(cornerRadius: 12))
            
            Text(type.description)
                .padding()
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 12))
            
            HStack {
                Spacer()
                
                Button("Play", action: onPressPlayButton)
                
                Spacer()
            }
        }
    }
    
    var body: some View {
        Group {
            if isExpanded {
                expandedView
                
            } else {
                closedView
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
