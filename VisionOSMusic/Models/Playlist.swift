
struct Playlist: Identifiable, Hashable, Equatable {
    let id: String
    let name: String
    let image: String
    let author: String
    let likes: Int
    let description: String?
    let songs: [Song]
    
    var authors: String {
        songs.map { $0.author }.joined(separator: ", ")
    }
    
    var totalDuration: String {
        songs.reduce(0) { $0 + ($1.duration.timeToInt() ?? 0) }
            .secondsFormattedToString()
    }
}
