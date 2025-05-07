//
//  Bundle+.swift
//  HEAITH
//
//  Created by 안세훈 on 5/7/25.
//

import Foundation

enum APIKeyManager {
    static var clientID: String {
        guard let url = Bundle.main.url(forResource: "API_KEY", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
              let clientID = plist["client_id"] as? String else {
            fatalError("client_id not found in API_KEY.plist")
        }
        return clientID
    }
}

