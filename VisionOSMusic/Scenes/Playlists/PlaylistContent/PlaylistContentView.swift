
import SwiftUI

struct PlaylistContentView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    private let playlist: Playlist
    
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
                //put your placeholder here
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
                    Text(playlist.name)
                        .font(.extraLargeTitle)
                        .fontWeight(.bold)
                    
                    Text(playlist.author)
                        .fontWeight(.light)
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
            .background {
                LinearGradient(colors: [.green, .clear], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(.all, edges: .all)
            }
            
            Table(playlist.songs) {
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
            
        }
        .padding()
    }
}

#Preview {
    PlaylistContentView(playlist: Playlist.mockPlaylist)
        .environment(MainViewModel())
        .glassBackgroundEffect()
}
