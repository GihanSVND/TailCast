//
//  GeminiAPIKey.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-09-03.
//

import Foundation

enum APIkey {
    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
        else {
            fatalError("Couldn't find the file")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find the API key")
        }
        if value.starts(with: "_") {
            fatalError("Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key.")
        }
        return value
    }
}
