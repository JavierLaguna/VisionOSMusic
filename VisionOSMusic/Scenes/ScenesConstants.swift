
struct WindowName {
    
    static let splash = "SplashWindow"
    static let main = "MainWindow"
    static let smallPlayer = "SmallPlayerWindow"
    static let drumDemo = "DrumDemoWindow"
    static let posters = "PostersWindow"
    static let snareDrum = "SnareDrumWindow"
    static let videoPlayer = "VideoPlayerWindow"
    static let portal = "PortalWindow"
}

struct Scene3D {
    
    static let intro = "IntroScene"
    static let drums = "DrumSetScene"
    static let guitar = "GuitarScene"
    static let violin = "ViolinScene"
    static let sticks = "SticksScene"
    static let snareDrum = "SnareDrumScene"
    
    struct DrumDemo {
        
        static let name = "DrumDemoScene"
        
        struct Sticks {
            static let ride = "StickRide"
        }
        
        struct SoundEmitter {
            static let kick = "KickEmitter"
            static let snare = "SnareEmitter"
            static let cymbal = "RideEmitter"
        }
    }
}
