
import Observation

@Observable
final class MainViewModel {
    
    let playlists = Playlist.mockPlaylists
    
    var currentPlaylist: Playlist? = nil
    var currentSong: Song? = nil {
        didSet {
            onChangeCurrentSong()
        }
    }
    var currentSongSecond: Int? = nil
    var status: PlayerStatus = .stopped {
        didSet {
            onChangeStatus()
        }
    }
    
    var isPlaying: Bool {
        status == .playing
    }
    
    var currentSongIndex: Int? {
        guard let currentSong else {
            return nil
        }
        
        return currentPlaylist?.songs.firstIndex(of: currentSong)
    }
    
    var playingSliderValue: Double { // Between 0 and 1
        guard let currentSong, let currentSongSecond else {
            return 0.0
        }
        
        return (1.0 * Double(currentSongSecond)) / Double(currentSong.durationSegs)
    }
    
    func play(_ playlist: Playlist) {
        currentPlaylist = playlist
        currentSong = playlist.songs.first
        
        status = .playing
    }
    
    func previousSong() {
        guard let currentSongIndex,
              let previousSongIndex = currentPlaylist?.songs.index(before: currentSongIndex),
              let previousSong = currentPlaylist?.songs[safeIndex: previousSongIndex]
        else {
            return
        }
    
        currentSong = previousSong
    }
    
    func nextSong() {
        guard let currentSongIndex,
              let nextSongIndex = currentPlaylist?.songs.index(after: currentSongIndex),
              let nextSong = currentPlaylist?.songs[safeIndex: nextSongIndex]
        else {
            return
        }
    
        currentSong = nextSong
    }
    
    func onPressPlayPauseButton() {
        if isPlaying {
            status = .paused
        } else if currentSong != nil {
            status = .playing
        }
    }
}

private extension MainViewModel {
    
    func onChangeCurrentSong() {
        currentSongSecond = currentSong != nil ? 0 : nil
    }
    
    func onChangeStatus() {
        if isPlaying {
            Task {
                await updatePlayingTime()
            }
        }
    }
    
    func updatePlayingTime() async {
        guard isPlaying, let currentSongSecond, let currentSong else {
            return
        }
        
        let nextSec = currentSongSecond + 1
        print("Updated time:", nextSec, playingSliderValue)
        if nextSec <= currentSong.durationSegs {
            self.currentSongSecond = nextSec
            
            await TimerUtils.waitTime(time: .seconds(1))
            
            await updatePlayingTime()
            
        } else {
            nextSong()
        }
    }
}
