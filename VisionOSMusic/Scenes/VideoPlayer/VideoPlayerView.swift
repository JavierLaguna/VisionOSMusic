
import SwiftUI
import RealityKit
import AVKit


enum ImmersionStylesSelectable: CaseIterable {
    case automatic
    case mixed
    case progressive
    case full
}


struct VideoPlayerView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    private let immersionStyles: [ImmersionStyle] = [.mixed, .progressive, .full]
    
    @State private var player: AVPlayer?
    
    private var isPlayingVideo: Bool {
        player?.timeControlStatus == .playing
    }
    
    private var immersionStyleSelected: Binding<String> {
        Binding(
            get: {
                switch viewModel.immersionStyle {
                    case is FullImmersionStyle:
                    return "FULL"
                    
                default:
                    return ""
                }
            },
            set: { _ in viewModel.immersionStyle = .full }
        )
    }
    
    @ViewBuilder
    private var videoPlayerControls: some View {
        HStack(spacing: 32) {
            Picker("Immersion Style", selection: immersionStyleSelected) {
                Text("PRUEBA")
                    .tag("")
                
                Text("PRUEB2")
                    .tag("PRUEB2")
                
                Text("FULL")
            }
            .pickerStyle(.segmented)
            
            Button(action: togglePlayPause, label: {
                Image(systemName: isPlayingVideo ? "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 88)
                    .contentTransition(.symbolEffect(.replace))
                    .symbolEffect(.bounce, value: isPlayingVideo)
            })
            
            Button(action: toggleMute, label: {
                Image(systemName: player?.isMuted ?? false ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
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
        let videoAsset = AVURLAsset(url: Bundle.main.url(forResource: "battery", withExtension: "mp4")!) // TODO: JLI !
        
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
        
        self.player?.isMuted = true // TODO: REMOVE
        
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

    var body: some View {
        RealityView { content, _ in
            let videoPlayerEntity = headRelativeVideo()
            content.add(videoPlayerEntity)
                       
        } update: { content, attachments in
            guard let videoPlayerEntity = content.entities.first,
                  let attachmentEntity = attachments.entity(for: "att") else {
                return
            }
            
            videoPlayerEntity.addChild(attachmentEntity)
            // TODO: JLI get position
            attachmentEntity.setPosition([0, -0.56, -1.8], relativeTo: videoPlayerEntity)
            
        } attachments: {
            Attachment(id: "att") { // TODO: JLI
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
