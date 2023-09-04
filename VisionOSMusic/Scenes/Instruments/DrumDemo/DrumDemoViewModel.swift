
import Observation
import RealityKit
import RealityKitContent

@Observable
final class DrumDemoViewModel {
    
    private let realitySceneFileName = "\(Scene3D.DrumDemo.name).usda"
    private let audioQuery = EntityQuery(where: .has(SpatialAudioComponent.self))
    
    var rootEntity: Entity?
    var stickEntity: Entity?
    
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
    
    func onTapPlay(of piece: DrumKitPieceComponent.PieceType) async {
        switch piece {
        case .kick, .snare:
            playSound(of: piece)
            
        case .cymbal:
            await cymbalPlay()
        }
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
    
    func playSound(of piece: DrumKitPieceComponent.PieceType) {
        let audioPlaybackController = audioControllers[piece]
        audioPlaybackController?.play()
    }
    
    func cymbalPlay() async {
        showCymbalStick()
        await rotateDownCymbalStick()
        await moveDownCymbalStick()
        playSound(of: .cymbal)
        await moveUpCymbalStick()
        
        await TimerUtils.waitTime(time: .seconds(0.25))
        hideCymbalStick()
    }
    
    func showCymbalStick() {
        stickEntity?.components.set(OpacityComponent(opacity: 1.0))
    }
    
    func hideCymbalStick() {
        stickEntity?.components.set(OpacityComponent(opacity: 0.0))
    }
    
    func rotateDownCymbalStick() async {
        if let stickEntity {
            let duration = 0.2
            var transform = await stickEntity.transform
            
            transform.rotation = simd_quatf(angle: 0.1, axis: SIMD3(1.0, 0.0, 0.0))
            await stickEntity.move(
                to: transform,
                relativeTo: rootEntity,
                duration: duration,
                timingFunction: .easeInOut
            )
            await TimerUtils.waitTime(time: .seconds(duration))
        }
    }
    
    func moveDownCymbalStick() async {
        if let stickEntity {
            var transform = await stickEntity.transform
            
            transform.translation = SIMD3(0, -0.265, 0)
            await stickEntity.move(
                to: transform,
                relativeTo: stickEntity,
                duration: 0.5,
                timingFunction: .easeInOut
            )
            await TimerUtils.waitTime(time: .seconds(0.4))
        }
    }
    
    func moveUpCymbalStick() async {
        if let stickEntity {
            var transform = await stickEntity.transform
            
            transform.translation = SIMD3(0, 0.265, 0)
            await stickEntity.move(
                to: transform,
                relativeTo: stickEntity,
                duration: 0.5,
                timingFunction: .easeInOut
            )
            await TimerUtils.waitTime(time: .seconds(0.5))
        }
    }
}
