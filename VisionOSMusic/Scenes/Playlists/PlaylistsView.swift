
import SwiftUI

struct PlaylistsView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    @State private var selectedListId: String?
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.playlists, selection: $selectedListId) { list in
                PlaylistCellView(playlist: list)
            }
            .navigationTitle("Playlists")
            
        } detail: {
            if let selectedListId,
               let selectedPlaylist = viewModel.playlists.first(where: { selectedListId == $0.id }) {
                
                PlaylistContentView(playlist: selectedPlaylist)
                    .navigationTitle(selectedPlaylist.description ?? "")
                
            } else {
                Text("TODO MAIN VIEW")
            }
        }
    }
}

#Preview {
    PlaylistsView()
        .environment(MainViewModel())
}
