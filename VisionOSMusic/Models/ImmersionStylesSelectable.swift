
import SwiftUI

enum ImmersionStylesSelectable: CaseIterable, Identifiable, Equatable {
    case automatic
    case mixed
    case progressive
    case full
    
    init(from immersionStyle: ImmersionStyle) {
        switch immersionStyle {
        case is AutomaticImmersionStyle: self = .automatic
        case is MixedImmersionStyle: self = .mixed
        case is ProgressiveImmersionStyle: self = .progressive
        case is FullImmersionStyle: self = .full
        default: self = .automatic
        }
    }
    
    var id: Int {
        self.hashValue
    }
    
    var style: ImmersionStyle {
        switch self {
        case .automatic: .automatic
        case .mixed: .mixed
        case .progressive: .progressive
        case .full: .full
        }
    }
}

extension ImmersionStylesSelectable {
 
    var title: String {
        switch self {
        case .automatic: "Automatic"
        case .mixed: "Mixed"
        case .progressive: "Progressive"
        case .full: "Full"
        }
    }
    
    var image: String {
        switch self {
        case .automatic: "auto.brakesignal"
        case .mixed: "macwindow"
        case .progressive: "film.circle"
        case .full: "rectangle.inset.filled.and.person.filled"
        }
    }
}
