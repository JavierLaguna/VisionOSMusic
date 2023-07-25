
import SwiftUI

struct PlayerControls: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    var body: some View {
        HStack(spacing: 32) {
            Button {
                viewModel.previousSong()
            } label: {
                Image(systemName: "backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
            }
            
            Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 48)
            
            Button {
                viewModel.nextSong()
            } label: {
                Image(systemName: "forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                
            }
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
