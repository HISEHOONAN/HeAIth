//
//  AlanDTO.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import Foundation

//MARK: - AI Request DTO
struct AlanRequestDTO: Codable {
    let client_id : String
    let message: String
}

//MARK: - AI Response DTO
struct AlanResponseDTO: Codable {
    let action: Action
    let content: String
}
struct Action: Codable {
    let name, speak: String
}
