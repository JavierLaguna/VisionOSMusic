
import SwiftUI

struct PlaylistsView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    @Environment(PlaylistsCoordinator.self) private var coordinator
    
    @State private var selectedListId: String?
    
    private func showHome() {
        selectedListId = nil
    }
    
    var body: some View {
        NavigationSplitView {
            VStack(alignment: .leading, spacing: 16) {
                Button(action: showHome, label: {
                    HStack {
                        Image(systemName: "house.fill")
                        
                        Text("Home")
                    }
                })
                .buttonStyle(.borderless)
                .padding(.horizontal)
                
                List(viewModel.playlists, selection: $selectedListId) { list in
                    PlaylistCellView(playlist: list)
                }
            }
            .navigationTitle("Playlists")
            
        } detail: {
            NavigationStack(path: coordinator.pathBinding) {
                Group {
                    if let selectedListId,
                       let selectedPlaylist = viewModel.playlists.first(where: { selectedListId == $0.id }) {
                        
                        PlaylistContentView(playlist: selectedPlaylist)
                        
                    } else {
                        PlaylistsMainContentView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .navigationDestination(for: PlaylistsCoordinator.Routes.self) { $0 }
            }
        }
    }
}

#Preview {
    PlaylistsView()
        .environment(MainViewModel())
}
