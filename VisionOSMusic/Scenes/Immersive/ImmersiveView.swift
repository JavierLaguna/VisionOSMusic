
import SwiftUI

struct ImmersiveView: View {
    
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    // TODO: JLI MOVE
    enum ImmersiveSpaceState {
        case video360
        case closed
    }
    
    @State private var immersiveSpaceState: ImmersiveSpaceState = .closed
    
    private func select(immersiveSpace newState: ImmersiveSpaceState) {
        if newState == immersiveSpaceState {
            immersiveSpaceState = .closed
        } else {
            immersiveSpaceState = newState
            
            TimerUtils.executeOnMainThreadAfter() {
                dismissWindow(id: WindowName.main)
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(spacing: 16) {
                    Spacer()
                    
                    Image(systemName: "field.of.view.ultrawide")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .clipShape(.rect(cornerRadius: 8))
                        .overlay {
                            Image(systemName: "video.fill")
                        }
                    
                    Spacer()
                    
                    Text("360 Video")
                }
                .padding()
                .frame(width: 160, height: 230)
                .background(.background)
                .clipShape(.rect(cornerRadius: 8))
                .padding()
                .hoverEffect(.automatic)
                .onTapGesture {
                    select(immersiveSpace: .video360)
                }
            }
        }
        .onChange(of: immersiveSpaceState) { oldValue, newValue in
            Task {
                if oldValue != .closed {
                    await dismissImmersiveSpace()
                }
                
                switch newValue {
                case .video360:
                    await openImmersiveSpace(id: WindowName.video360)
                default:
                    break
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ImmersiveView()
    }
    .allEnvironmentsInjected
}
