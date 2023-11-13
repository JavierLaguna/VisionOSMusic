
import Foundation

struct BusinessConstants {
    
    struct UserDefaults {
        static let introEnabled = "UD_IntroEnabled"
        static let favoriteImmersiveBg = "UD_FavoriteImmersiveBg"
    }
    
    struct DefaultValues {
        static let introEnabled = true
        static let favoriteImmersiveBg = ImmersiveBackgroundScene.starfield
    }
    
    static let repoURL = URL(string: "https://github.com/JavierLaguna/VisionOSMusic")!
}
