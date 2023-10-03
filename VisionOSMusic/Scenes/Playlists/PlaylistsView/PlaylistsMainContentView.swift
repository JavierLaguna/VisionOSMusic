
import SwiftUI

struct PlaylistsMainContentView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Header(playlists: viewModel.highlighPlaylist)
            
            ForEach(viewModel.recommendationCategories) {
                PlaylistsCarousel(
                    title: $0.title,
                    playlists: $0.playlists
                )
            }
        }
        .padding()
    }
}

private struct Header: View {
    
    private let numberOfRows = 3
    private let playlists: [Playlist]
    
    init(playlists: [Playlist]) {
        self.playlists = playlists
    }
    
    @ViewBuilder
    private func list(of playlists: [Playlist]) -> some View {
        VStack {
            ForEach(playlists) { playlist in
                NavigationLink(value: PlaylistsCoordinator.Routes.playlist(playlist)) {
                    HStack {
                        Image(playlist.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 56, height: 56)
                        Text(playlist.name)
                            .font(.subheadline)
                        
                        Spacer()
                    }
                    .background(.background)
                    .clipShape(.rect(cornerRadius: 4))
                    .hoverEffect(.highlight)
                }
                .plainNavLink
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Good Morning!")
                .font(.title)
                .padding(.top, 32)
                .padding(.horizontal)
            
            HStack(spacing: 16) {
                list(of: Array(playlists.prefix(numberOfRows)))
                
                list(of: Array(playlists.suffix(numberOfRows)))
            }
            .padding()
        }
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 16))
    }
}

private struct PlaylistsCarousel: View {
    
    private let title: String
    private let playlists: [Playlist]
    
    init(title: String, playlists: [Playlist]) {
        self.title = title
        self.playlists = playlists
    }
    
    private func item(playlist: Playlist) -> some View {
        NavigationLink(value: PlaylistsCoordinator.Routes.playlist(playlist)) {
            VStack(alignment: .leading, spacing: 16) {
                Image(playlist.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 8))
                
                VStack(alignment: .leading) {
                    Text(playlist.name)
                        .font(.title3)
                    
                    Text(playlist.authors)
                        .font(.caption)
                        .lineLimit(2)
                }
            }
            .padding()
            .frame(width: 160, height: 230)
            .background(.background)
            .clipShape(.rect(cornerRadius: 8))
            .padding()
            .hoverEffect(.highlight)
        }
        .plainNavLink
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title2)
                .padding(.top, 32)
                .padding(.horizontal)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(playlists) {
                        item(playlist: $0)
                    }
                }
            }
        }
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    PlaylistsMainContentView()
        .mockPlaylistNavStacked
}
