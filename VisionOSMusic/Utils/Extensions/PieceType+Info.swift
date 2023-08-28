
import RealityKitContent

extension DrumKitPieceComponent.PieceType {
    
    var name: String {
        switch self {
        case .kick: "Bass drum"
        case .snare: "Snare"
        case .cymbal: "Cymbal"
        }
    }
    
    var image: String {
        switch self {
        case .kick: ""
        case .snare: "snare_image"
        case .cymbal: "cymbal_image"
        }
    }
    
    var description: String {
        switch self {
        case .kick: "Bass Drum: It's the largest drum and is played with a pedal. It generates the low-frequency sound that marks the fundamental rhythm of the music."
        case .snare: "Snare Drum: Also known as a snare, it's a central drum that has a set of wires or snares on the bottom, which gives it its characteristic 'crack' sound. It's played with drumsticks and plays an important role in the rhythmic structure."
        case .cymbal: "Cymbals: These metallic discs are played with drumsticks or mallets and add a tonal and rhythmic dimension to the drum kit. Cymbals can vary in size and thickness to produce different sounds, ranging from subtle to explosive."
        }
    }
}
