
import SwiftUI

struct MainView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            PlaylistsView()
                .tabItem {
                    Label("Playlists", systemImage: "music.note.list")
                }
            
            NavigationStack {
                MainInstrumentsView()
            }
            .tabItem {
                Label("Instruments", systemImage: "guitars.fill")
            }
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
        .ornament(
            attachmentAnchor: .scene(alignment: .bottom),
            contentAlignment: .top
        ) {
            PlayerControls()
        }
        .ornament(
            visibility: viewModel.currentSong == nil ? .hidden : .automatic,
            attachmentAnchor: .scene(alignment: .topTrailing)
        ) {
            if let currentSong = viewModel.currentSong {
                SongPlayer(song: currentSong)
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

