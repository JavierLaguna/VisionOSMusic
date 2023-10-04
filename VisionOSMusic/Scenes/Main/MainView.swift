
import SwiftUI

struct MainView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    @Environment(MainCoordinator.self) private var coordinator
    
    var body: some View {
        TabView(selection: coordinator.tabSelectionBinding) {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            PlaylistsView()
                .tabItem {
                    Label("Playlists", systemImage: "music.note.list")
                }
                .tag(1)
            
            NavigationStack {
                MainInstrumentsView()
            }
            .tabItem {
                Label("Instruments", systemImage: "guitars.fill")
            }
            .tag(2)
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
            .tag(3)
        }
        .ornament(
            attachmentAnchor: .scene(.bottom),
            contentAlignment: .top
        ) {
            PlayerControls()
        }
        .ornament(
            visibility: viewModel.currentSong == nil ? .hidden : .automatic,
            attachmentAnchor: .scene(.topTrailing)
        ) {
            SongPlayer()
        }
    }
}

#Preview {
    MainView()
        .environment(MainViewModel())
        .environment(MainCoordinator())
        .environment(PlaylistsCoordinator())
}

