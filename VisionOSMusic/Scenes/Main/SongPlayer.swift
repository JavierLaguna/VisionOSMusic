
import SwiftUI

struct SongPlayer: View {

    private let song: Song
    
    @State private var slider = 0.0
    
    init(song: Song) {
        self.song = song
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: song.albumCover)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    //put your placeholder here
                }
                .frame(width: 48, height: 48)
                
                VStack(alignment: .leading) {
                    Text(song.name)
                        .fontWeight(.semibold)
                    
                    Text(song.author)
                        .font(.caption)
                        .fontWeight(.light)
                }
            }
            
            HStack {
                Text("0:00")
                    .font(.caption2)
                    .fontWeight(.light)
            
                Slider(value: $slider, in: 0...1)
                    .disabled(true)
                    .frame(width: 180)
                
                Text(song.duration)
                    .font(.caption2)
                    .fontWeight(.light)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 32)
        .glassBackgroundEffect()
    }
}

#Preview {
    SongPlayer(song: Song.mockSong)
}
