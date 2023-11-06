
import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Environment(MainViewModel.self) private var viewModel
    @Environment(MainCoordinator.self) private var mainCoordinator
    @Environment(PlaylistsCoordinator.self) private var playlistsCoordinator
    
    private let spacing: CGFloat = 8.0
    
    @State private var infoIsOpen = false
    
    private func openPostersScene() {
        Task {
            await openImmersiveSpace(id: WindowName.posters)
        }
    }
    
    private func openSmallPlayer() {
        openWindow(id: WindowName.smallPlayer)
        
        TimerUtils.executeOnMainThreadAfter() {
            dismissWindow(id: WindowName.main)
        }
    }
    
    private func onPressInfo() {
        infoIsOpen = true
    }
    
    private func closeInfoView() {
        infoIsOpen = false
    }
    
    private func onPressRapPlaylist() {
        navigateToPlaylist(playlist: Playlist.mockRapPlaylist)
    }
    
    private func onPressRockPlaylist() {
        navigateToPlaylist(playlist: Playlist.mockRockPlaylist)
    }
    
    private func onPressFunkPlaylist() {
        navigateToPlaylist(playlist: Playlist.mockFunkPlaylist)
    }
    
    private func onPressPopPlaylist() {
        navigateToPlaylist(playlist: Playlist.mockPopPlaylist)
    }
    
    private func onPressTechnoPlaylist() {
        navigateToPlaylist(playlist: Playlist.mockTechnoPlaylist)
    }
    
    private func navigateToPlaylist(playlist: Playlist) {
        mainCoordinator.navigateToPlaylist()
        
        TimerUtils.executeOnMainThreadAfter() {
            playlistsCoordinator.navigateTo(playlist: playlist)
        }
    }
    
    @ViewBuilder
    private func playListImage(_ name: String) -> some View {
        Image(name)
            .resizable()
            .hoverEffect(.lift)
    }
    
    @ViewBuilder
    private var userSection: some View {
        VStack(spacing: spacing * 2) {
            Image(viewModel.user.avatar)
                .resizable()
                .scaledToFit()
                .shadow(color: .accent, radius: 10)
            
            Text(viewModel.user.name)
                .font(.title2)
        }
        .embeddedOnSectionContainer(spacing: spacing)
    }
    
    @ViewBuilder
    private var iconsSection: some View {
        VStack(spacing: spacing * 2) {
            HStack(spacing: spacing * 3) {
                iconButton(icon: "gear", action:  mainCoordinator.navigateToSettingsTab)
                
                shareButton
            }
            
            HStack(spacing: spacing * 3) {
                iconButton(icon: "play.rectangle.on.rectangle.circle", action: openSmallPlayer)
                
                iconButton(icon: "info.circle.fill", action: onPressInfo)
            }
        }
        .embeddedOnSectionContainer(spacing: spacing)
    }
    
    @ViewBuilder
    private var immersionSection: some View {
        Image("vision_pro")
            .resizable()
            .scaledToFit()
            .shadow(radius: 10)
            .overlay(alignment: .bottom) {
                Text("Immersion")
                    .font(.title3)
                    .offset(z: 8)
                    .shadow(color: .primary, radius: 22, y: 4)
            }
            .embeddedOnSectionContainer(spacing: spacing)
            .onTapGesture(perform: openPostersScene)
    }
    
    @ViewBuilder
    private var instrumentsSection: some View {
        Model3D(named: Scene3D.guitar, bundle: realityKitContentBundle) { model in
            model
                .resizable()
                .scaledToFit()
            
        } placeholder: {
            LoadingView()
        }
        .embeddedOnSectionContainer(spacing: spacing)
        .onTapGesture(perform: mainCoordinator.navigateToInstruments)
    }
    
    @ViewBuilder
    private func iconButton(icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action, label: {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .shadow(radius: 12)
        })
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private var shareButton: some View {
        ShareLink(
            item: BusinessConstants.repoURL,
            preview: SharePreview(
                " VisionOS Music repository",
                image: Image("user_avatar")
            )
        ) {
            Image(systemName: "square.and.arrow.up.circle")
                .resizable()
                .scaledToFit()
                .shadow(radius: 12)
        }
        .buttonStyle(.plain)
    }
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let mainSpaceWidth = (width / 2) - (spacing / 2)
            
            VStack(spacing: spacing) {
                HStack(spacing: spacing) {
                    playListImage("playlist_rap")
                        .frame(width: mainSpaceWidth)
                        .onTapGesture(perform: onPressRapPlaylist)
                    
                    VStack(spacing: spacing) {
                        userSection
                        
                        immersionSection
                    }
                    
                    VStack(spacing: spacing) {
                        iconsSection
                        
                        instrumentsSection
                    }
                }
                .frame(width: .infinity, height: proxy.size.height * 0.65)
                
                HStack(spacing: spacing) {
                    playListImage("playlist_rock")
                        .onTapGesture(perform: onPressRockPlaylist)
                    
                    playListImage("playlist_funk")
                        .onTapGesture(perform: onPressFunkPlaylist)
                    
                    playListImage("playlist_pop")
                        .onTapGesture(perform: onPressPopPlaylist)
                    
                    playListImage("playlist_techno")
                        .onTapGesture(perform: onPressTechnoPlaylist)
                }
            }
        }
        .sheet(isPresented: $infoIsOpen, content: {
            InfoView(onPressClose: closeInfoView)
        })
    }
}

private extension View {
    
    func embeddedOnSectionContainer(spacing: CGFloat) -> some View {
        self.modifier(
            SectionContainerModifier(spacing: spacing)
        )
    }
}

private struct SectionContainerModifier: ViewModifier {
    
    private let spacing: CGFloat
    
    init(spacing: CGFloat) {
        self.spacing = spacing
    }
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(spacing * 2)
            .background(.background)
            .hoverEffect(.highlight)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .allEnvironmentsInjected
}
