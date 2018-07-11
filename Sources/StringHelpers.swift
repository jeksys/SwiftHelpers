import Foundation
import UIKit

extension String {
    func appendingPathComponent(_ string: String) -> String {
        return URL(fileURLWithPath: self).appendingPathComponent(string).path
    }
}

extension String {
    var hex: Int? {
        return Int(self, radix: 16)
    }
}

extension String {
    // NSLocalizedString shorthand
    // show erros if localization is missing
    // show erros if localization is missing
    var localized: String {
        //TODO: record all unresolved keys
        var localizedString = NSLocalizedString(self, comment: "")
        if localizedString == self {
            localizedString = NSLocalizedStringFallback(self, comment: "")
            if LogOptions.localization {
                if localizedString == self {
                    print("missing localization: \(self)")
                }else{
                    print("missing localization for \(String(describing: Locale.current.languageCode)): \(self)")
                }
            }
        }
        LocalizationManager.shared.addLocalization(key: self, string: localizedString)
        return localizedString
    }
    
    public func NSLocalizedStringFallback(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String) -> String {
        let fallbackLanguage = "Base"
        guard let fallbackBundlePath = Bundle.main.path(forResource: fallbackLanguage, ofType: "lproj") else { return key }
        guard let fallbackBundle = Bundle(path: fallbackBundlePath) else { return key }
        let fallbackString = fallbackBundle.localizedString(forKey: key, value: comment, table: nil)
        return Bundle.main.localizedString(forKey: key, value: fallbackString, table: nil)
    }
}



// indexes
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension String {
    var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}

