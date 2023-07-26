
import SwiftUI

struct PlayerControls: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    var body: some View {
        HStack(spacing: 32) {
            Button(action: viewModel.previousSong, label: {
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
                    .padding(.leading, viewModel.isPlaying ? 0 : 8)
            })
            
            Button(action: viewModel.nextSong, label: {
                Image(systemName: "forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                
            })
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
