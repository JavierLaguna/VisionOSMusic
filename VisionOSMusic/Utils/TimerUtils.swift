
final class TimerUtils {
    
    static func waitTime(time: Duration) async {
        do {
            try await Task.sleep(until: .now + time, clock: .continuous)
        } catch {
            print("ERROR - waitTime - \(error.localizedDescription)")
        }
    }
}
