
import SwiftUI

struct Video360ControlsView: View {
    
    @Environment(Video360ViewModel.self) private var viewModel
    
    @State private var sliderProgress: Double = 0
    
    var body: some View {
        HStack(spacing: 20) {
            HStack {
                Button {
                    viewModel.isPlayingVideo = !viewModel.isPlayingVideo
                } label: {
                    Label(viewModel.isPlayingVideo ? "Pause" : "Play", systemImage: viewModel.isPlayingVideo ? "pause.fill" : "play.fill")
                        .contentTransition(.symbolEffect(.replace.downUp.byLayer))
                        .labelStyle(IconOnlyLabelStyle())
                }
                Button {
                    viewModel.isPlayingVideo = false
                } label: {
                    Label("Stop", systemImage: "square.fill")
                        .labelStyle(IconOnlyLabelStyle())
                }
            }
            
            Slider(value: $sliderProgress, in: 0...viewModel.videoDuration) { editing in
//                viewModel.isPlayingVideo = false
                viewModel.seek(to: sliderProgress)
            }
        }
        .padding(24)
        .glassBackgroundEffect()
    }
}

#Preview {
    Video360ControlsView()
}
