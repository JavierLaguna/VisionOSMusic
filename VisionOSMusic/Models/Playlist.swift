
struct Playlist: Identifiable, Equatable {
    let id: String
    let name: String
    let image: String
    let author: String
    let likes: Int
    let description: String?
    let songs: [Song]
}
