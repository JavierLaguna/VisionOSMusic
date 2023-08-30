
import SwiftUI

struct SettingsView: View {
    
    @AppStorage(BusinessConstants.UserDefaults.introEnabled)
    private var introEnabled: Bool = BusinessConstants.DefaultValues.introEnabled
    
    @State var pickerSelection = "Option 1"
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Button(action: {}, label: {
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
    }
}

#Preview {
    SettingsView()
        .glassBackgroundEffect()
}
