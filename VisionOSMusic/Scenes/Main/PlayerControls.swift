
import SwiftUI

struct PlayerControls: View {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(MainViewModel.self) private var viewModel
    
    private func openSmallPlayer() {
        openWindow(id: WindowName.smallPlayer)
        
        Task {
            await TimerUtils.waitTime(time: .seconds(0.25))
            
            await MainActor.run {
                dismissWindow(id: WindowName.main)
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 32) {
            Button(action: viewModel.playPreviousSong, label: {
                Image(systemName: "backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
            })
            
            Button(action: viewModel.onPressPlayPauseButton, label: {
                Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 88)
                    .contentTransition(.symbolEffect(.replace))
                    .symbolEffect(.bounce, value: viewModel.isPlaying)
            })
            
            Button(action: viewModel.playNextSong, label: {
                Image(systemName: "forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
            })
            
            Button(action: openSmallPlayer, label: {
                Image(systemName: "window.shade.open")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16)
            })
            .disabled(viewModel.currentSong == nil)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 32)
        .clipShape(.capsule)
        .glassBackgroundEffect()
    }
}

#Preview {
    PlayerControls()
        .environment(MainViewModel())
        .previewLayout(.sizeThatFits)
}
