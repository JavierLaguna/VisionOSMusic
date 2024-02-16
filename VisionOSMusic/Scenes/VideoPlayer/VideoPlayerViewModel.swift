
import Observation
import RealityKit
import AVKit

@Observable
final class VideoPlayerViewModel {
    
    let immersionStyles: [ImmersionStylesSelectable] = [.mixed, .progressive, .full]
    
    private(set) var videoPlayerEntity: Entity
    private(set) var player: AVPlayer
    private(set) var immersiveBg: ImmersiveBackgroundScene = BusinessConstants.DefaultValues.favoriteImmersiveBg
    
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
        let avPlayer = AVPlayer()
        player = avPlayer
        
        videoPlayerEntity = Self.headRelativeVideo(player: avPlayer)
    }
    
    func setInitial(immersiveBg: ImmersiveBackgroundScene) {
        self.immersiveBg = immersiveBg
    }
    
    func load(videoclip: SongVideoclip) {
        guard let assetUrl = getVideoAssetUrl(from: videoclip) else {
            return
        }
        
        let videoAsset = AVURLAsset(url: assetUrl)
        let playerItem = AVPlayerItem(asset: videoAsset)
        
        player.replaceCurrentItem(with: playerItem)
        isPlayingVideo = true
    }
    
    func randomImmersiveBg() {
        guard let newBg = ImmersiveBackgroundScene.allCases.randomElement() else {
            return
        }
        
        if immersiveBg == newBg {
            randomImmersiveBg()
        } else {
            immersiveBg = newBg
        }
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
        
        var videoPlayerComponent = VideoPlayerComponent(avPlayer: player)
        videoPlayerComponent.isPassthroughTintingEnabled = true
        
        entity.components[VideoPlayerComponent.self] = videoPlayerComponent
        
        // Make player small
        // entity.scale *= 0.4
        
        return entity
    }
    
    func getVideoAssetUrl(from videoclip: SongVideoclip) -> URL? {
        switch videoclip {
        case let .local(name, format):
            if let assetUrl = Bundle.main.url(
                forResource: name,
                withExtension: format
            ) {
                return assetUrl
            }
            
        case let .remote(url):
            if let assetUrl = URL(string: url) {
                return assetUrl
            }
        }
        
        return nil
    }
}
