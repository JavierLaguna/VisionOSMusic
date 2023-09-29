
import Observation
import SwiftUI

@Observable
final class PlaylistsCoordinator {
    
    var path: [Routes] = []
    var pathBinding: Binding<[Routes]> {
        Binding(
            get: { self.path },
            set: { self.path = $0 }
        )
    }
    
    func navigateTo(playlist: Playlist) {
        path.append(.playlist(playlist))
    }
    
    func navigateTo(song: Song) {
        path.append(.song(song))
    }
}

// MARK: Routes
extension PlaylistsCoordinator {
    
    enum Routes: Hashable, View {
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
