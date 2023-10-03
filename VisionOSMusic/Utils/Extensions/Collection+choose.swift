
extension Collection {
    
    func choose(_ n: Int) -> Array<Element> {
        Array(shuffled().prefix(n))
    }
}
