
import Observation
import RealityKit
import RealityKitContent

@Observable
final class DrumDemoViewModel {
    
    private let realitySceneFileName = "\(Scene3D.drumsDemo).usda"
    private let audioQuery = EntityQuery(where: .has(SpatialAudioComponent.self))
    
    var rootEntity: Entity?
    
    private var audioControllers = [DrumKitPieceComponent.PieceType: AudioPlaybackController]()
    
    private var hasSetUpAudio: Bool {
        !audioControllers.isEmpty
    }
    
    @MainActor
    func setupAudio() {
        Task {
            guard !hasSetUpAudio, let scene = rootEntity?.scene else { return }
            
            scene.performQuery(audioQuery).forEach({ audioEmitter in
                
                guard let type = getPieceType(by: audioEmitter.name),
                      let resource = try? AudioFileResource.load(named: type.soundPath,
                                                                 from: realitySceneFileName,
                                                                 in: realityKitContentBundle) else {
                    return
                }
                
                let audioPlaybackController = audioEmitter.prepareAudio(resource)
                audioControllers[type] = audioPlaybackController
            })
        }
    }
    
    func playSound(of piece: DrumKitPieceComponent.PieceType) {
        let audioPlaybackController = audioControllers[piece]
        audioPlaybackController?.play()
    }
}

// MARK: Private methods
private extension DrumDemoViewModel {
    
    func getPieceType(by audioEmitterName: String) -> DrumKitPieceComponent.PieceType? {
        switch audioEmitterName {
        case Scene3D.DrumDemo.SoundEmitter.kick: DrumKitPieceComponent.PieceType.kick
        case Scene3D.DrumDemo.SoundEmitter.snare: DrumKitPieceComponent.PieceType.snare
        case Scene3D.DrumDemo.SoundEmitter.cymbal: DrumKitPieceComponent.PieceType.cymbal
        default: nil
        }
    }
}
