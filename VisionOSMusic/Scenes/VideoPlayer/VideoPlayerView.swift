
import SwiftUI
import RealityKit
import AVKit

struct VideoPlayerView: View {
    
    static private let playerControlsAttachmentId = "playerControlsAttachmentId"
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(MainViewModel.self) private var viewModel
    
    private let immersionStyles: [ImmersionStylesSelectable] = [.mixed, .progressive, .full]
    
    @State private var player: AVPlayer?
    
    private var isPlayingVideo: Bool {
        player?.timeControlStatus == .playing
    }
    
    private var immersionStyleSelected: Binding<ImmersionStylesSelectable> {
        Binding(
            get: { ImmersionStylesSelectable(from: viewModel.immersionStyle) },
            set: { viewModel.immersionStyle = $0.style }
        )
    }
    
    @ViewBuilder
    private var videoPlayerControls: some View {
        HStack(spacing: 32) {
            Button(action: toggleMute, label: {
                Image(systemName: player?.isMuted ?? false ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding()
            })
            
            Button(action: togglePlayPause, label: {
                Image(systemName: isPlayingVideo ? "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 88)
                    .contentTransition(.symbolEffect(.replace))
                    .symbolEffect(.bounce, value: isPlayingVideo)
                    .padding()
            })
            
            Picker("Immersion Style", selection: immersionStyleSelected) {
                ForEach(immersionStyles) { style in
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
        viewModel.immersionStyle = .progressive
    }
    
    private func headRelativeVideo() -> Entity {
        let headAnchor = AnchorEntity(.head, trackingMode: .once)
        let videoPlayerEntity = makeVideoPlayerEntity()
        videoPlayerEntity.position = SIMD3<Float>(0, 0, -2)
        headAnchor.addChild(videoPlayerEntity)
        
        return headAnchor
    }
    
    private func makeVideoPlayerEntity() -> Entity {
        let entity = Entity()
        
        guard let videoclip = viewModel.immersionVideoclip,
              let assetUrl = Bundle.main.url(
                forResource: videoclip.name,
                withExtension: videoclip.format
              ) else {
            return entity
        }
        
        let videoAsset = AVURLAsset(url: assetUrl)
        let playerItem = AVPlayerItem(asset: videoAsset)
        
        let player = AVPlayer()
        player.replaceCurrentItem(with: playerItem)
        
        var videoPlayerComponent = VideoPlayerComponent(avPlayer: player)
        videoPlayerComponent.isPassthroughTintingEnabled = true
        
        entity.components[VideoPlayerComponent.self] = videoPlayerComponent
        
        // Make player small
        // entity.scale *= 0.4
        
        self.player = player
        self.player?.play()
                
        return entity
    }
    
    private func togglePlayPause() {
        guard let player else { return }
        
        if isPlayingVideo {
            player.pause()
        } else {
            player.play()
        }
    }
    
    private func toggleMute() {
        guard let player else { return }
        
        player.isMuted = !player.isMuted
    }
    
    private func closeScene() {
        player?.pause()
        
        openWindow(id: WindowName.main)
        
        Task {
            await dismissImmersiveSpace()
        }
    }
    
    var body: some View {
        RealityView { content, _ in
            let videoPlayerEntity = headRelativeVideo()
            content.add(videoPlayerEntity)
            
        } update: { content, attachments in
            guard let videoPlayerEntity = content.entities.first,
                  let attachmentEntity = attachments.entity(for: Self.playerControlsAttachmentId) else {
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
    VideoPlayerView()
        .environment(MainViewModel())
}
