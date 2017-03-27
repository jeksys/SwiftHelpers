import Foundation
import UIKit

@available(*, deprecated, message: "unimplemented ")
var TODO: Never{
    fatalError("unimplemented")
}
@available(*, deprecated, message: "Fix this")
var FIXME: Void{ return }

extension Bundle{

    class var versionString : String {
        get{
            if let dictionary = Bundle.main.infoDictionary, let version = dictionary["CFBundleShortVersionString"] as? String, let build = dictionary["CFBundleVersion"] as? String{
                return "\(version).\(build)"
            }
            return ""
        }
    }
    class var versionStringShort : String {
        get{
            if let dictionary = Bundle.main.infoDictionary, let version = dictionary["CFBundleShortVersionString"] as? String{
                return "\(version)"
            }
            return ""
        }
    }

}



/**
 Executes the closure on the main queue after a set amount of seconds.
 */
func delayOnMainQueue(delay: Double = 0, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

/**
 Executes the closure on a background queue after a set amount of seconds.
 */
func delayOnBackgroundQueue(delay: Double = 0, closure: @escaping ()->()) {
    DispatchQueue.global().asyncAfter(deadline: .now() + delay){
        closure()
    }
}

var GlobalMainQueue: DispatchQueue {
    return DispatchQueue.main
}

var GlobalUserInteractiveQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
}

var GlobalUserInitiatedQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
}

var GlobalUtilityQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
}

var GlobalBackgroundQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
}

public extension UIDevice {
    
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhone35
        case iPhone4
        case iPhone47
        case iPhone55
        case iPad
        case iPadPro
        case Unknown
    }
    
    var screenType: ScreenType {
        let maxDimenshion = max(UIScreen.main.nativeBounds.height, UIScreen.main.nativeBounds.width)
        switch maxDimenshion {
        case 960:
            return .iPhone35
        case 1136:
            return .iPhone4
        case 1334:
            return .iPhone47
        case 1920:
            return .iPhone55
        case 2208:
            return .iPhone55
        case 2048:
            return .iPad
        case 2732:
            return .iPadPro
        default:
            return .Unknown
        }
    }
    
}
