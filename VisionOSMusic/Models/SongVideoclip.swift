
enum SongVideoclip: Equatable, Hashable {
    case local(name: String, format: String)
    case remote(url: String)
}
