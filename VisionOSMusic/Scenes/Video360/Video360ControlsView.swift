
import SwiftUI
import PhotosUI

struct Video360ControlsView: View {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @Environment(Video360ViewModel.self) private var viewModel
    
    @State private var sliderProgress: Double = 0
    
    private func toggleMute() {
        viewModel.isMuted.toggle()
    }
    
    private func togglePlayPause() {
        viewModel.isPlayingVideo.toggle()
    }
    
    private func closeScene() {
        viewModel.isPlayingVideo = false
        
        Task {
            await dismissImmersiveSpace()
        }
        
        openWindow(id: WindowName.main)
        dismissWindow(id: WindowName.video360Controls)
    }
    
    var body: some View {
        HStack(spacing: 24) {
            
            VideoPickerView()
            
            Button(action: togglePlayPause) {
                Image(systemName: viewModel.isPlayingVideo ? "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 88)
                    .contentTransition(.symbolEffect(.replace))
                    .symbolEffect(.bounce, value: viewModel.isPlayingVideo)
                    .padding()
            }
            
            Button(action: toggleMute) {
                Image(systemName: viewModel.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding()
            }
            
            
            Slider(value: $sliderProgress, in: 0...viewModel.videoDuration) { editing in
                viewModel.seek(to: sliderProgress)
            }
            .onChange(of: viewModel.progress) { _, newValue in
                withAnimation {
                    sliderProgress = newValue
                }
            }
            
            Button(action: closeScene) {
                Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding()
            }
        }
        .padding(24)
        .glassBackgroundEffect()
    }
}

private struct VideoPickerView: View {
    
    @Environment(Video360ViewModel.self) private var viewModel
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    private func useSelectedItem() async {
        defer {
            selectedItem = nil
        }
        
        guard let selectedItem else { return }
        
        var videoURL: URL?
        
        do {
            if let result = try await selectedItem.loadTransferable(type: URL.self) {
                videoURL = result
                
            } else if let result = try await selectedItem.loadTransferable(type: Data.self) {
                let fileExt = selectedItem.supportedContentTypes.contains([UTType.mpeg4Movie]) ? "mp4" : "mov"
                
                let tmpFileURL = URL.temporaryDirectory.appending(path: "\(UUID().uuidString).\(fileExt)")
                
                try result.write(to: tmpFileURL)
                videoURL = tmpFileURL
            }
        } catch {
            print("ERROR:", error)
        }
        
        if let videoURL {
            viewModel.load(url: videoURL)
        }
    }
    
    var body: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .videos
        ) {
            Image(systemName: "photo.badge.plus")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
                .padding()
        }
        .task(id: selectedItem) {
            await useSelectedItem()
        }
    }
}

#Preview {
    Video360ControlsView()
}
