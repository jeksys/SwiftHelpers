import UIKit

struct FontFamily {
    enum Helvetica: String {
        case Regular = "Helvetica"
        case Bold = "Helvetica-Bold"
        case Thin = "Helvetica-Thin"
        case Medium = "Helvetica-Medium"
        
        func font(size: CGFloat) -> UIFont? { return UIFont(name:self.rawValue, size:size)}
    }
}

