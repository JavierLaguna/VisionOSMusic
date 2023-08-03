
import SwiftUI

struct SongPlayer: View {

    @Environment(MainViewModel.self) private var viewModel

    // TODO: Remove use viewModel song
    private let song: Song
    
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
                Text(viewModel.currentSongSecond?.secondsFormattedToString() ?? "0:00")
                    .font(.caption2)
                    .fontWeight(.light)
                    .monospacedDigit()
            
                Slider(value: .constant(viewModel.playingSliderValue), in: 0...1)
                    .tint(.accentColor)
                    .frame(width: 180)
                    .animation(.linear, value: viewModel.playingSliderValue)
                
                Text(song.duration)
                    .font(.caption2)
                    .fontWeight(.light)
                    .monospacedDigit()
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 32)
        .glassBackgroundEffect()
    }
}

#Preview {
    SongPlayer(song: Song.mockSong)
        .environment(MainViewModel())
}
