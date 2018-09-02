//
//  StringLocalization.swift
//  SelfTaping
//
//  Created by Evgeny Yagrushkin on 2018-07-11.
//  Copyright © 2018 Casting Workbook Services Inc. All rights reserved.
//

import Foundation

extension String {
    // NSLocalizedString shorthand
    // show erros if localization is missing
    // show erros if localization is missing
    
    func localized(value: String)-> String {
        //TODO: record all unresolved keys
        var localizedString = NSLocalizedString(self, comment: "")
        if localizedString == self {
            localizedString = NSLocalizedStringFallback(self, comment: "")
            if localizedString == self {
                localizedString = value
            }
            if LogOptions.localization {
                if localizedString == self {
                    print("missing localization: \(self)")
                }else{
                    print("missing localization for \(String(describing: Locale.current.languageCode)): \(self)")
                }
            }
        }
//        if let (en, fr) = AllLocalizations(self){
//            var _en = en.replacingOccurrences(of: "\n", with: "\\n", options: .literal, range: nil)
//            var _fr = fr.replacingOccurrences(of: "\n", with: "\\n", options: .literal, range: nil)
//            if _en.contains(","){
//                _en = "\"\(_en)\""
//            }
//            if _fr.contains(","){
//                _fr = "\"\(_fr)\""
//            }
//            let loc_area = self.split(separator: ".").first ?? ""
//            LocalizationManager.shared.allLocalizationKeys[self] = "\(self),\(loc_area),\(_en),\(_fr)"
//        }
//        LocalizationManager.shared.addLocalization(key: self, string: localizedString)
        return localizedString
    }
    
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
//        if let (en, fr) = AllLocalizations(self){
//            var _en = en.replacingOccurrences(of: "\n", with: "\\n", options: .literal, range: nil)
//            var _fr = fr.replacingOccurrences(of: "\n", with: "\\n", options: .literal, range: nil)
//            if _en.contains(","){
//               _en = "\"\(_en)\""
//            }
//            if _fr.contains(","){
//                _fr = "\"\(_fr)\""
//            }
//            let loc_area = self.split(separator: ".").first ?? ""
//            LocalizationManager.shared.allLocalizationKeys[self] = "\(self),\(loc_area),\(_en),\(_fr)"
//        }
//        LocalizationManager.shared.addLocalization(key: self, string: localizedString)
        return localizedString
    }
    
    public func NSLocalizedStringFallback(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String) -> String {
        let fallbackLanguage = "Base"
        guard let fallbackBundlePath = Bundle.main.path(forResource: fallbackLanguage, ofType: "lproj") else { return key }
        guard let fallbackBundle = Bundle(path: fallbackBundlePath) else { return key }
        let fallbackString = fallbackBundle.localizedString(forKey: key, value: comment, table: nil)
        return Bundle.main.localizedString(forKey: key, value: fallbackString, table: nil)
    }
    
    public func AllLocalizations(_ key: String) -> (String, String)? {
        guard let baseBundlePath = Bundle.main.path(forResource: "Base", ofType: "lproj") else { return nil }
        guard let frBundlePath = Bundle.main.path(forResource: "fr", ofType: "lproj") else { return nil }
        
        guard let baseBundle = Bundle(path: baseBundlePath) else { return nil }
        guard let frBundle = Bundle(path: frBundlePath) else { return nil }

        let baseString = baseBundle.localizedString(forKey: key, value: nil, table: nil)
        let frString = frBundle.localizedString(forKey: baseString, value: baseString, table: nil)
        return (baseString, frString)
    }

}
