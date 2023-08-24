
struct WindowName {
    
    static let splash = "SplashWindow"
    static let main = "MainWindow"
    static let smallPlayer = "SmallPlayerWindow"
    static let drumDemo = "DrumDemoWindow"
}

struct Scene3D {
    
    static let intro = "IntroScene"
    static let drums = "DrumSetScene"
    static let guitar = "GuitarScene"
    static let violin = "ViolinScene"
    static let sticks = "SticksScene"
    static let drumsDemo = "DrumDemoScene"
    
    struct DrumDemo {
    
        struct SoundEmitter {
            static let kick = "KickEmitter"
            static let snare = "SnareEmitter"
            static let cymbal = "RideEmitter"
        }
    }
}
