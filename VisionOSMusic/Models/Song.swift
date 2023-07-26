
struct Song: Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let album: String
    let albumCover: String
    let author: String
    let duration: String
    
    var durationSegs: Int {
        60 // TODO: Unmock
    }
}
