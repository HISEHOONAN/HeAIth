//
//  AlanEndpoint.swift
//  HEAITH
//
//  Created by 안세훈 on 5/5/25.
//

import Foundation

struct AlanEndpoint {
    static func requestAlan(with AlanRequest : AlanRequestDTO) -> Endpoint<AlanResponseDTO> {
        return Endpoint(path: "https://kdt-api-function.azurewebsites.net/api/v1/question?client_id=3547aab8-ebb6-4821-8229-10717383851d&content=", method: .get)
    }
}
