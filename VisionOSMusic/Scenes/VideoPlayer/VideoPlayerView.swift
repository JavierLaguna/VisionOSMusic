
import SwiftUI
import RealityKit
import AVKit

struct VideoPlayerView: View {
    
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
        
        player.play() // TODO: JLI Move
        player.isMuted = true // TODO: JLI Move
        
        return entity
    }
    
    var body: some View {
        RealityView { content in
            let videoPlayer = headRelativeVideo()
            content.add(videoPlayer)
        }
    }
}

#Preview {
    VideoPlayerView()
}
