
final class TimerUtils {
    
    static func waitTime(time: Duration) async {
        do {
            try await Task.sleep(until: .now + time, clock: .continuous)
        } catch {
            print("ERROR - waitTime - \(error.localizedDescription)")
        }
    }
    
    static func executeOnMainThreadAfter(
        waitTime: Duration = .seconds(0.25),
        closure: @escaping () -> Void
    ) {
        Task {
            await TimerUtils.waitTime(time: waitTime)
            
            await MainActor.run {
                closure()
            }
        }
    }
}
