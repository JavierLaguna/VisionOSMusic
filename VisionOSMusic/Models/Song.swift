
struct Song: Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let album: String
    let albumCover: String
    let author: String
    let duration: String
    let lyrics: String
    let youtubeId: String?
    let songVideoclip: SongVideoclip?
    
    var durationOnSegs: Int? {
        duration.timeToInt()
    }
    
    init(id: String, name: String, album: String, albumCover: String, author: String, duration: String, lyrics: String, youtubeId: String? = nil, songVideoclip: SongVideoclip? = nil) {
        self.id = id
        self.name = name
        self.album = album
        self.albumCover = albumCover
        self.author = author
        self.duration = duration
        self.lyrics = lyrics
        self.youtubeId = youtubeId
        self.songVideoclip = songVideoclip
    }
}
