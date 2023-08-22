
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
                
                DrumKitPieceComponent.PieceType.allCases.forEach {
                    guard let resource = try? AudioFileResource.load(named: $0.soundPath,
                                                                     from: realitySceneFileName,
                                                                     in: realityKitContentBundle) else { return }
                    
                    let audioPlaybackController = audioEmitter.prepareAudio(resource)
                    audioControllers[$0] = audioPlaybackController
                }
                
            })
        }
    }
    
    func playKickSound() {
        let audioPlaybackController = audioControllers[.kick]
        audioPlaybackController?.play()
    }
}
