
import SwiftUI

struct PlaylistsView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
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
            NavigationStack {
                if let selectedListId,
                   let selectedPlaylist = viewModel.playlists.first(where: { selectedListId == $0.id }) {
                    
                    PlaylistContentView(playlist: selectedPlaylist)
                    
                } else {
                    PlaylistsMainContentView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    PlaylistsView()
        .environment(MainViewModel())
}
