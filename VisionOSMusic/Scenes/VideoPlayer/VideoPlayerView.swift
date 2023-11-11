
import SwiftUI
import RealityKit

struct VideoPlayerView: View {
    
    static private let bgImageResource = "starfield_bg_scene"
    static private let bgImageEntityName = "bgImageEntityName"
    static private let playerControlsAttachmentId = "playerControlsAttachmentId"
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(MainViewModel.self) private var mainViewModel
    
    @State private var viewModel: VideoPlayerViewModel!
    
    private var immersionStyleSelected: Binding<ImmersionStylesSelectable> {
        Binding(
            get: {
                ImmersionStylesSelectable(from: mainViewModel.immersionStyle)
            },
            set: {
                mainViewModel.immersionStyle = $0.style
            }
        )
    }
    
    init(videoclip: SongVideoclip) {
        viewModel = VideoPlayerViewModel(videoclip: videoclip)
    }
    
    @ViewBuilder
    private var videoPlayerControls: some View {
        HStack(spacing: 32) {
            Button(action: toggleMute, label: {
                Image(systemName: viewModel.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding()
            })
            
            Button(action: togglePlayPause, label: {
                Image(systemName: viewModel.isPlayingVideo ? "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 88)
                    .contentTransition(.symbolEffect(.replace))
                    .symbolEffect(.bounce, value: viewModel.isPlayingVideo)
                    .padding()
            })
            
            Picker("Immersion Style", selection: immersionStyleSelected) {
                ForEach(viewModel.immersionStyles) { style in
                    Label(style.title, systemImage: style.image)
                        .tag(style)
                }
            }
            .pickerStyle(.segmented)
            
            Button(action: closeScene, label: {
                Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding()
            })
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 32)
        .glassBackgroundEffect(in: .capsule)
    }
    
    private func onAppearView() {
        mainViewModel.immersionStyle = .progressive
        viewModel.isPlayingVideo = true
    }
    
    private func togglePlayPause() {
        viewModel.isPlayingVideo.toggle()
    }
    
    private func toggleMute() {
        viewModel.isMuted.toggle()
    }
    
    private func closeScene() {
        viewModel.isPlayingVideo = false
        
        mainViewModel.immersionStyle = .mixed
        
        openWindow(id: WindowName.main)
        
//        Task {
//            await TimerUtils.waitTime(time: .seconds(0.25))
//            
//            await dismissImmersiveSpace()
//        }
    }
    
    var body: some View {
        RealityView { content, _ in
            let backgroundEntity = ImmersiveViewBackground(imageResource: Self.bgImageResource)
            backgroundEntity.name = Self.bgImageEntityName
            content.add(backgroundEntity)
            
            let videoPlayerEntity = viewModel.videoPlayerEntity
            content.add(videoPlayerEntity)
            
        } update: { content, attachments in
            if let backgroundEntity = content.entities.first(where: {
                $0.name == Self.bgImageEntityName
            }) {
                backgroundEntity.components.set(OpacityComponent(opacity: immersionStyleSelected.wrappedValue == .mixed ? 0.0 : 1.0))
            }
            
            let videoPlayerEntity = content.entities[1] // TODO: JLI
            guard let attachmentEntity = attachments.entity(for: Self.playerControlsAttachmentId) else {
                return
            }
            
            videoPlayerEntity.addChild(attachmentEntity)
            // TODO: JLI get position
            attachmentEntity.setPosition([0, -0.56, -1.8], relativeTo: videoPlayerEntity)
            
        } attachments: {
            Attachment(id: Self.playerControlsAttachmentId) {
                videoPlayerControls
            }
        }
        .onAppear(perform: onAppearView)
    }
}

#Preview {
    VideoPlayerView(
        videoclip: SongVideoclip(name: "battery", format: "mp4")
    )
    .environment(MainViewModel())
}
