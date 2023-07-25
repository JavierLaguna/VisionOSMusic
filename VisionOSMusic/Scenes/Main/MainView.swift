
import SwiftUI

struct MainView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    var body: some View {
        TabView {
            Image(.playlistRock)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            PlaylistsView()
                .tabItem {
                    Label("Playlists", systemImage: "music.note.list")
                }
        }
        .ornament(attachmentAnchor: .scene(alignment: .bottom)) {
            PlayerControls()
        }
        .ornament(
            visibility: viewModel.currentSong == nil ? .hidden : .automatic,
            attachmentAnchor: .scene(alignment: .topTrailing)
        ) {
            if let currentSong = viewModel.currentSong {
                SongPlayer(song: currentSong)
                    .offset(y: -60)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
            .environment(MainViewModel())
    }
    .padding()
}

