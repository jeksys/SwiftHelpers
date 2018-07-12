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
