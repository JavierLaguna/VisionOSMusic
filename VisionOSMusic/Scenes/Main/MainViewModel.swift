
import Observation
import SwiftUI

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
    
    var playingSliderValue: Double { // Between 0.0 and 1.0
        guard let currentSongSecond,
              let currentSongDuration = currentSong?.durationOnSegs
        else {
            return 0.0
        }
        
        return (1.0 * Double(currentSongSecond)) / Double(currentSongDuration)
    }
    
    private var hasNextSong: Bool {
        getNextSong() != nil
    }
    
    func play(_ playlist: Playlist) {
        currentPlaylist = playlist
        currentSong = playlist.songs.first
        
        status = .playing
    }
    
    func play(_ song: Song) {
        currentPlaylist = nil
        currentSong = song
        
        status = .playing
    }
    
    func playPreviousSong() {
        guard let currentSongIndex,
              let previousSongIndex = currentPlaylist?.songs.index(before: currentSongIndex),
              let previousSong = currentPlaylist?.songs[safeIndex: previousSongIndex]
        else {
            return
        }
        
        currentSong = previousSong
    }
    
    func playNextSong() {
        guard let nextSong = getNextSong() else {
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
        } else if status == .stopped {
            currentSongSecond = 0
        }
    }
    
    func updatePlayingTime() async {
        guard isPlaying,
              let currentSongSecond,
              let currentSongDuration = currentSong?.durationOnSegs
        else {
            return
        }
        
        let nextSec = currentSongSecond + 1
        print("Updated time:", nextSec, playingSliderValue)
        
        if nextSec <= currentSongDuration {
            self.currentSongSecond = nextSec
        } else if hasNextSong {
            playNextSong()
        } else {
            onFinishPlaylist()
        }
        
        await TimerUtils.waitTime(time: .seconds(1))
        
        await updatePlayingTime()
    }
    
    func getNextSong() -> Song? {
        guard let currentPlaylist,
              let currentSongIndex
        else {
            return nil
        }
        
        return currentPlaylist.songs[safeIndex: currentPlaylist.songs.index(after: currentSongIndex)]
    }
    
    func onFinishPlaylist() {
        status = .stopped
    }
}
