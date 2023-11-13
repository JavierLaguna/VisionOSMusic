
import SwiftUI

struct SettingsView: View {
    
    @AppStorage(BusinessConstants.UserDefaults.introEnabled)
    private var introEnabled: Bool = BusinessConstants.DefaultValues.introEnabled
    
    @AppStorage(BusinessConstants.UserDefaults.favoriteImmersiveBg)
    private var favoriteImmersiveBg: ImmersiveBackgroundScene = BusinessConstants.DefaultValues.favoriteImmersiveBg
    
    @State private var infoIsOpen = false
    
    private func openInfoView() {
        infoIsOpen = true
    }
    
    private func closeInfoView() {
        infoIsOpen = false
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Button(action: openInfoView, label: {
                Image(systemName: "info.circle.fill")
            })
            .padding(.trailing, 32)
            
            Form {
                Section("Settings") {
                    Toggle(isOn: $introEnabled) {
                        Text("Splash intro animation")
                    }
                    
                    Picker(selection: $favoriteImmersiveBg) {
                        ForEach(ImmersiveBackgroundScene.allCases) { bg in
                            Text(bg.title)
                                .tag(bg.rawValue)
                        }
                    } label: {
                        Text("Favorite immersive scene")
                    }
                }
            }
        }
        .padding(.vertical, 32)
        .sheet(isPresented: $infoIsOpen, content: {
            InfoView(onPressClose: closeInfoView)
        })
    }
}

#Preview {
    SettingsView()
}
