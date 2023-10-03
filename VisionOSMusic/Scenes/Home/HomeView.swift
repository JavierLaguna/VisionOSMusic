
import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    private let spacing: CGFloat = 8.0
    
    private func toggleDemo() {
        Task {
            await openImmersiveSpace(id: WindowName.posters)
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                HStack {
                    Image("playlist_rap")
                        .resizable()
                        .frame(width: (proxy.size.width / 2 - 4))
                        .hoverEffect(.highlight)
                    
                    VStack {
                        VStack(spacing: 16) {
                            Image(viewModel.user.avatar)
                                .resizable()
                                .scaledToFit()
                                .shadow(color: .accent, radius: 10)
                            
                            Text(viewModel.user.name)
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(.background)
                        .hoverEffect(.highlight)
                        
                        VStack(spacing: 16) {
                            Image("vision_pro")
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 10)
                                .overlay(alignment: .bottom) {
                                    Text("Immersion")
                                        .font(.title3)
                                        .offset(z: 8)
                                        .shadow(color: .primary, radius: 22, y: 4)
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(.background)
                        .hoverEffect(.highlight) // TODO: JLI
                    }
                    
                    VStack {
                        VStack(spacing: 16) {
                            HStack(spacing: 24) {
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Image(systemName: "gear")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 12)
                                })
                                .buttonStyle(.plain)
                                
                                Image(systemName: "square.and.arrow.up.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .shadow(radius: 12)
                            }
                            
                            HStack(spacing: 24) {
                                Image(systemName: "play.rectangle.on.rectangle.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .shadow(radius: 12)
                                
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .shadow(radius: 12)
                            }

                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(.background)
                        
                        
                        VStack(spacing: 16) {
                            Model3D(named: Scene3D.guitar, bundle: realityKitContentBundle) { model in
                                model
                                    .resizable()
                                    .scaledToFit()
                                
                            } placeholder: {
                                LoadingView()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(.background)
                        .hoverEffect(.lift) // TODO: JLI
                    }
                }
                .frame(width: .infinity, height: proxy.size.height * 0.65)
                
                HStack {
                    Group {
                        Image("playlist_rock")
                            .resizable()
                        
                        Image("playlist_funk")
                            .resizable()
                        
                        Image("playlist_pop")
                            .resizable()
                        
                        Image("playlist_techno")
                            .resizable()
                    }
                    .hoverEffect(.highlight)
                }
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environment(MainViewModel())
}
