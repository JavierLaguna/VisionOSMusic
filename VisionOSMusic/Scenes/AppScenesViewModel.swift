
import Observation

@Observable
final class AppScenesViewModel {
    
    var didFinishInto = false
    
    init() {
        startIntro()
    }
}

private extension AppScenesViewModel {
    
    func startIntro() {
        Task {
            await TimerUtils.waitTime(time: .seconds(6))
            
            print("Intro did finish")
            didFinishInto = true
        }
    }
}
