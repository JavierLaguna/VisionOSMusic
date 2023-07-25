
import Observation

@Observable
final class MainViewModel {
    
    let playlists = Playlist.mockPlaylists
    
    var isPlaying = false
    var currentPlaylist: Playlist? = nil
    var currentSong: Song? = nil
    
    var currentSongIndex: Int? {
        guard let currentSong else {
            return nil
        }
        
        return currentPlaylist?.songs.firstIndex(of: currentSong)
    }
    
    func play(_ playlist: Playlist) {
        currentPlaylist = playlist
        currentSong = playlist.songs.first
        
        isPlaying = true
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
}

