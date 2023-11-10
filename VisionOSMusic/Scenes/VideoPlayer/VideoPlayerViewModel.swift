
import Observation
import RealityKit
import AVKit

@Observable
final class VideoPlayerViewModel {
    
    let immersionStyles: [ImmersionStylesSelectable] = [.mixed, .progressive, .full]
    
    private(set) var videoPlayerEntity: Entity
    private(set) var player: AVPlayer
    
    var isPlayingVideo: Bool = false {
        didSet {
            if isPlayingVideo {
                player.play()
            } else {
                player.pause()
            }
        }
    }
    var isMuted: Bool = false {
        didSet {
            player.isMuted = isMuted
        }
    }
    
    init() {
        let player = AVPlayer()
        self.player = player
        
        videoPlayerEntity = Self.headRelativeVideo(player: player)
    }
}

// MARK: Private methods
private extension VideoPlayerViewModel {
    
    static func headRelativeVideo(player: AVPlayer) -> Entity {
        let headAnchor = AnchorEntity(.head, trackingMode: .once)
        let videoPlayerEntity = makeVideoPlayerEntity(player: player)
        videoPlayerEntity.position = SIMD3<Float>(0, 0, -2)
        headAnchor.addChild(videoPlayerEntity)
        
        return headAnchor
    }
    
    static func makeVideoPlayerEntity(player: AVPlayer) -> Entity {
        let entity = Entity()
        
        // TODO: JLI
        let videoclip = SongVideoclip(name: "battery", format: "mp4")
        
        guard let assetUrl = Bundle.main.url(
            forResource: videoclip.name,
            withExtension: videoclip.format
        ) else {
            return entity
        }
        
        let videoAsset = AVURLAsset(url: assetUrl)
        let playerItem = AVPlayerItem(asset: videoAsset)
        
        player.replaceCurrentItem(with: playerItem)
        
        var videoPlayerComponent = VideoPlayerComponent(avPlayer: player)
        videoPlayerComponent.isPassthroughTintingEnabled = true
        
        entity.components[VideoPlayerComponent.self] = videoPlayerComponent
        
        // Make player small
        // entity.scale *= 0.4
        
        return entity
    }
}
