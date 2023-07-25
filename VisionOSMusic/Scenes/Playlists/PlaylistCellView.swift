
import SwiftUI

struct PlaylistCellView: View {
    
    private let playlist: Playlist
    
    init(playlist: Playlist) {
        self.playlist = playlist
    }
    
    var body: some View {
        HStack {
            Image(playlist.image)
                .resizable()
                .frame(width: 64, height: 64)
            
            VStack(alignment: .leading) {
                Text(playlist.name)
                    .font(.title)
                
                HStack {
                    Text(playlist.author)
                        .font(.footnote)
                    
                    Spacer()
                    
                    Text("\(playlist.likes)")
                        .font(.footnote)
                    
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            }
        }
    }
}

#Preview {
    PlaylistCellView(playlist: Playlist.mockPlaylist)
        .previewLayout(.sizeThatFits)
}
