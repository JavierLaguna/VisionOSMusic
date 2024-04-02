
import Observation
import AVKit

@Observable
final class Video360ViewModel {
    
    private(set) var player: AVPlayer
    private(set) var videoDuration: Double = 1
    private(set) var progress: Double = 0
    
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
    }
    
    func load(name: String) {
        guard let assetUrl = getAssetUrl(name: name) else {
            return
        }
        
        let videoAsset = AVURLAsset(url: assetUrl)
        let playerItem = AVPlayerItem(asset: videoAsset)
        
        player.replaceCurrentItem(with: playerItem)
        
        updateVideoDuration()
        isPlayingVideo = true
        
        // TODO: JLI
        // Update progress
//        Task {
//            let clock = ContinuousClock()
//            let timerSequence = AsyncTimerSequence.repeating(every: .seconds(0.1), clock: clock)
//            let sequence = chain([clock.now].async, timerSequence)
//
//            for await _ in sequence where currentItemURL != nil {
//                progress = player.currentTime().seconds
//            }
//        }
    }
    
    func seek(to newProgress: Double) {
        let time = CMTime(seconds: newProgress, preferredTimescale: 600)
        player.seek(to: time)
        progress = newProgress
    }
}

// MARK: Private methods
private extension Video360ViewModel {
    
    func getAssetUrl(name: String) -> URL? {
        guard let assetUrl = Bundle.main.url(
            forResource: name,
            withExtension: "mp4"
        ) else {
            return nil
        }
        
        return assetUrl
    }
    
    func updateVideoDuration() {
        guard let asset = player.currentItem?.asset else { return }

        Task {
            let duration = try await asset.load(.duration)
            guard asset.status(of: .duration) == .loaded(duration) else { return }
            await MainActor.run {
                self.videoDuration = CMTimeGetSeconds(duration)
            }
        }
    }
}