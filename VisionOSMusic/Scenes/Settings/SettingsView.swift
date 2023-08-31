
import SwiftUI

struct SettingsView: View {
    
    @AppStorage(BusinessConstants.UserDefaults.introEnabled)
    private var introEnabled: Bool = BusinessConstants.DefaultValues.introEnabled
    
    @State private var pickerSelection = "Option 1"
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
                    
                    Picker(selection: $pickerSelection) {
                        Text("Option 1").tag("Option 1")
                        Text("Option 2").tag("Option 2")
                        Text("Option 3").tag("Option 3")
                    } label: {
                        Text("This is a simple picker")
                    }
                }
            }
        }
        .padding(.vertical, 32)
        .sheet(isPresented: $infoIsOpen, content: {
            VStack(spacing: 24) {
                HStack {
                    Spacer()
                    
                    Button(action: closeInfoView, label: {
                        Image(systemName: "xmark.circle.fill")
                    })
                }
                
                Text(" VisionOS Music")
                    .font(.extraLargeTitle)
                
                Text("My first xrOS App!")
                    .font(.body)
                
                Text("👨🏻‍💻 Javier Laguna 📱")
                    .font(.caption)
            }
            .padding(32)
        })
    }
}

#Preview {
    SettingsView()
        .glassBackgroundEffect()
}
