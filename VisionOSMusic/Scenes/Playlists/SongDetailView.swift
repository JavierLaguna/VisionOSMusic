
import SwiftUI

struct SongDetailView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    private let song: Song
    
    init(song: Song) {
        self.song = song
    }
    
    @ViewBuilder
    var header: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: song.albumCover)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    LoadingView()
                }
                .frame(width: 128, height: 128)
                .frame(depth: 50)
                .hoverEffect(.highlight)
                
                VStack(alignment: .leading) {
                    Text("Song")
                        .font(.caption)
                    
                    Text(song.name)
                        .font(.extraLargeTitle)
                        .fontWeight(.bold)
                    
                    Text(song.author)
                        .fontWeight(.light)
                    
                    HStack {
                        Image(systemName: "opticaldisc.fill")
                        
                        Text(song.album)
                            .fontWeight(.light)
                    }
                    
                    HStack {
                        Image(systemName: "timer")
                        
                        Text(song.duration)
                            .fontWeight(.light)
                    }
                }
                .padding(.top, 20)
                
                Spacer()
                
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48)
                    .onTapGesture {
                        viewModel.play(song)
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
        }
        .clipShape(.rect(cornerRadius: 16))
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
    }
    
    var body: some View {
        VStack {
            header
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Lyrics")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    ScrollView {
                        Text(song.lyrics)
                    }
                }
                
                Spacer()
                
                if let videoId = song.youtubeId {
                    YoutubePlayerView(videoId: videoId)
                        .frame(width: 600, height: 400)
                        .padding(.bottom)
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 32)
        }
        .navigationTitle("\(song.name) - \(song.author)")
    }
}

#Preview {
    NavigationStack{
        SongDetailView(song: Song.mockSong)
    }
    .environment(MainViewModel())
}
