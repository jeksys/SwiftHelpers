//
//  Bundle.swift
//  SelfTaping
//
//  Created by Evgeny Yagrushkin on 2017-09-29.
//  Copyright © 2017 Casting Workbook Services Inc. All rights reserved.
//

import Foundation

extension Bundle{
    func readJson(fileName: String) -> String? {
        do {
            if let file = self.url(forResource: fileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let jsonString = String(data: data, encoding: .utf8)
                return jsonString
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
