//
//  AIDTO.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import Foundation

//MARK: - AI Request DTO
struct AIRequest: Codable {
    let client_id : String
    let message: String
}

//MARK: - AI Response DTO
struct AIResponse: Codable {
    let action: Action
    let content: String
}
struct Action: Codable {
    let name, speak: String
}
