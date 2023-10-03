
import Foundation

struct RecommendationCategory: Identifiable, Equatable {
    let id = UUID().uuidString
    let title: String
    let playlists: [Playlist]
}
