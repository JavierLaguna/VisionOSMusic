
extension Int {
    
    func secondsFormattedToString() -> String {
        let mins = self / 60
        let seconds = self % 60
        
        let minsString = String(format: "%02d", mins)
        let secondsString = String(format: "%02d", seconds)
        
        return "\(minsString):\(secondsString)"
    }
}
