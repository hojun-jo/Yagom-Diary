//
//  Bundle+.swift
//  Diary
//
//  Created by 조호준 on 2023/09/13.
//

import Foundation

extension Bundle {
    var openWeatherAPIKey: String {
        guard let filePath = Bundle.main.path(forResource: "APIKey", ofType: "plist"),
              let plistDictionary = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file 'APIKey.plist'.")
        }
        
        guard let value = plistDictionary.object(forKey: "Open Weather") as? String else {
            fatalError("Couldn't find key 'Open Weather' in 'APIKey.plist'.")
        }
        
        return value
    }
}
