
extension String {
    
    func timeToInt() -> Int? {
        let components = self.components(separatedBy: ":")
        
        guard components.count == 2,
              let mins = Int(components[0]),
              let seconds = Int(components[1]) else {
            return nil
        }
        
        return mins * 60 + seconds
    }
}
