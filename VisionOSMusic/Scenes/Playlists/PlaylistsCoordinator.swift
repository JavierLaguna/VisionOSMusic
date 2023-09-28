
import Observation
import SwiftUI

@Observable
final class PlaylistsCoordinator {
    
//    var path = NavigationPath()
    var path: [Routes] = []
    
    func navigateTo(song: Song) {
        path.append(.song(song))
    }
}

// MARK: Routes
extension PlaylistsCoordinator {
    
    enum Routes: Hashable, View {
//        case home
        case playlist(Playlist)
        case song(Song)
        
        // MARK: View
        var body: some View {
            switch self {
            case .playlist(let playlist):
                PlaylistContentView(playlist: playlist)
                
            case .song(let song):
                SongDetailView(song: song)
            }
        }
    }
}
