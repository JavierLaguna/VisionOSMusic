
import SwiftUI

struct ExperiencesView: View {
    
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
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
    
    @ViewBuilder
    private func itemTitle(_ title: String) -> some View {
        Text(title)
            .font(.headline)
    }
    
    @ViewBuilder
    var video360Item: some View {
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
            
            itemTitle("360 Video")
        }
        .onTapGesture {
            select(immersiveSpace: .video360)
        }
    }
    
    @ViewBuilder 
    var cubeItem: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(systemName: "dice.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .clipShape(.rect(cornerRadius: 8))
            
            Spacer()
            
            itemTitle("Playlists dice")
        }
        .onTapGesture {
            select(immersiveSpace: .cube)
        }
    }
    
    @ViewBuilder
    var portalItem: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(systemName: "photo.artframe.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .clipShape(.rect(cornerRadius: 8))
            
            Spacer()
            
            itemTitle("Portal")
        }
        .onTapGesture {
            select(immersiveSpace: .portal)
        }
    }
    
    @ViewBuilder
    var portalLandscapeItem: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .clipShape(.rect(cornerRadius: 8))
            
            Spacer()
            
            itemTitle("Portal Landscape")
        }
        .onTapGesture {
            select(immersiveSpace: .portalLandscape)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    video360Item
                    cubeItem
                    portalItem
                    portalLandscapeItem
                }
                .padding()
                .frame(width: 160, height: 230)
                .background(.background)
                .clipShape(.rect(cornerRadius: 8))
                .padding()
                .hoverEffect(.automatic)
                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .onChange(of: immersiveSpaceState) { oldValue, newValue in
            Task {
                if oldValue != .closed {
                    await dismissImmersiveSpace()
                }
                
                switch newValue {
                case .video360: await openImmersiveSpace(id: WindowName.video360)
                case .cube: await openImmersiveSpace(id: WindowName.cube)
                case .portal: await openImmersiveSpace(id: WindowName.portal)
                case .portalLandscape: await openImmersiveSpace(id: WindowName.portalLandscape)
                default: break
                }
            }
        }
    }
}

// MARK: ImmersiveSpaceState
private extension ExperiencesView {
    
    enum ImmersiveSpaceState {
        case video360
        case cube
        case portal
        case portalLandscape
        case closed
    }
}

#Preview {
    NavigationStack {
        ExperiencesView()
    }
    .allEnvironmentsInjected
}
