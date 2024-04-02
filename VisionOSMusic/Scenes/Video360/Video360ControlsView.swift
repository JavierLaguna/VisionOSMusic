
import SwiftUI
import PhotosUI

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

private struct VideoPickerView: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    private func useSelectedItem() async {
        defer {
            selectedItem = nil
        }

        guard let selectedItem else { return}

        var videoURL: URL? = nil

        do {
            // Retrieve video as URL or Data
            if let result = try await selectedItem.loadTransferable(type: URL.self) {
                videoURL = result
            } else if let result = try await selectedItem.loadTransferable(type: Data.self) {
                let fileExt: String

                if selectedItem.supportedContentTypes.contains([UTType.mpeg4Movie]) {
                    fileExt = "mp4"
                } else {
                    fileExt = "mov"
                }

                let tmpFileURL = URL.temporaryDirectory.appending(path: "\(UUID().uuidString).\(fileExt)")

                try result.write(to: tmpFileURL)
                videoURL = tmpFileURL
            }
        } catch {
            print(error)
        }

        // Open video URL into immersive space
        if let videoURL {
            playerState.open(url: videoURL)
//            showImmersiveSpace = true
        }
    }
    
    var body: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .videos
        ) {
            Label(
                "Select a video from Library",
                systemImage: "photo.badge.plus"
            )
            .labelStyle(.iconOnly)
        }
        .task(id: selectedItem) {
            await useSelectedItem()
        }
    }
}

#Preview {
    Video360ControlsView()
}
