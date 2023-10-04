
import SwiftUI

struct SmallPlayerView: View {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(MainViewModel.self) private var viewModel
    
    private func restoreWindow() {
        openWindow(id: WindowName.main)
        
        TimerUtils.executeOnMainThreadAfter() {
            dismissWindow(id: WindowName.smallPlayer)
        }
    }
    
    var body: some View {
        Group {
            if let song = viewModel.currentSong {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: song.albumCover)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 12))
                    } placeholder: {
                        LoadingView()
                    }
                    
                    HStack {
                        Text(viewModel.currentSongSecond?.secondsFormattedToString() ?? "0:00")
                            .font(.caption2)
                            .fontWeight(.light)
                            .monospacedDigit()
                        
                        Slider(value: .constant(viewModel.playingSliderValue), in: 0...1)
                            .tint(.accentColor)
                            .animation(.linear, value: viewModel.playingSliderValue)
                        
                        Text(song.duration)
                            .font(.caption2)
                            .fontWeight(.light)
                            .monospacedDigit()
                    }
                    
                    HStack(spacing: 32) {
                        Button(action: viewModel.playPreviousSong, label: {
                            Image(systemName: "backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                        })
                        
                        Button(action: viewModel.onPressPlayPauseButton, label: {
                            Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 48)
                                .contentTransition(.symbolEffect(.replace))
                                .symbolEffect(.bounce, value: viewModel.isPlaying)
                        })
                        
                        Button(action: viewModel.playNextSong, label: {
                            Image(systemName: "forward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                        })
                    }
                }
                .overlay(alignment: .topTrailing) {
                    Button(action: restoreWindow, label: {
                        Image(systemName: "uiwindow.split.2x1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                        
                    })
                    .padding(4)
                }
                
            } else {
                EmptyView()
            }
        }
        .padding(24)
        .frame(width: 300)
        .glassBackgroundEffect()
    }
}

#Preview {
    SmallPlayerView()
        .environment(MainViewModel())
        .previewLayout(.sizeThatFits)
}
