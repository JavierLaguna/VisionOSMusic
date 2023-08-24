
import SwiftUI

struct PlaylistContentView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    private let playlist: Playlist
    
    @State private var selection: Song.ID?
    
    init(playlist: Playlist) {
        self.playlist = playlist
    }
    
    private func getSongPosition(song: Song) -> String {
        if let index = playlist.songs.firstIndex(of: song) {
            return "\(index)"
        }
        
        return ""
    }
    
    @ViewBuilder
    func songTableCell(song: Song) -> some View {
        HStack {
            AsyncImage(url: URL(string: song.albumCover)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                LoadingView()
            }
            .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(song.name)
                    .fontWeight(.semibold)
                
                Text(song.author)
                    .font(.footnote)
                    .fontWeight(.light)
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(playlist.image)
                    .resizable()
                    .frame(width: 128, height: 128)
                    .frame(depth: 50)
                    .hoverEffect(.highlight)
                
                VStack(alignment: .leading) {
                    Text("Playlist")
                        .font(.caption)
                    
                    Text(playlist.name)
                        .font(.extraLargeTitle)
                        .fontWeight(.bold)
                    
                    Text(playlist.author)
                        .fontWeight(.light)
                    
                    HStack {
                        Image(systemName: "timer")
                        
                        Text(playlist.totalDuration)
                            .fontWeight(.light)
                    }
                }
                
                Spacer()
                
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48)
                    .onTapGesture {
                        viewModel.play(playlist)
                    }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .background {
                GeometryReader {
                    LinearGradient(
                        colors: [.accent, .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: $0.size.height + 48)
                    .ignoresSafeArea(.all, edges: .all)
                }
            }
            
            Table(playlist.songs, selection: $selection) {
                TableColumn("#") {
                    Text(getSongPosition(song: $0))
                }
                .width(32)
                
                TableColumn("Song") {
                    songTableCell(song: $0)
                }
                
                TableColumn("Album", value: \.album)
                
                TableColumn("🕒", value: \.duration)
            }
            .navigationDestination(for: Song.self) { song in
                SongDetailView(song: song)
            }
            
        }
        .clipShape(.rect(cornerRadius: 16))
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
    }
}

#Preview {
    PlaylistContentView(playlist: Playlist.mockRockPlaylist)
        .environment(MainViewModel())
        .glassBackgroundEffect()
}