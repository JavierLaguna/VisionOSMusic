
import SwiftUI

struct SongDetailView: View {
    
    private let song: Song
    
    init(song: Song) {
        self.song = song
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(song.albumCover)
                        .resizable()
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
                            // viewModel.play(playlist)
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
        
            Spacer()
        }
        .navigationTitle("SONG")
    }
}

#Preview {
    SongDetailView(song: Song.mockSong)
        .glassBackgroundEffect()
}
