//
//  AICoachService.swift
//  HEAITH
//
//  Created by 안세훈 on 5/5/25.
//

import Foundation

final class AICoachService {
    func sendMessageToAI(_ message: String, completion: @escaping (String) -> Void) {
        let clientID = APIKeyManager.clientID
        guard let encodedContent = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion("메시지 인코딩 오류")
            return
        }

        let urlString = "https://kdt-api-function.azurewebsites.net/api/v1/question?client_id=\(clientID)&content=\(encodedContent)"
        guard let url = URL(string: urlString) else {
            completion("잘못된 URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion("네트워크 에러: \(error.localizedDescription)")
                return
            }

            guard let data = data,
                  let response = try? JSONDecoder().decode(AlanResponseDTO.self, from: data) else {
                completion("디코딩 실패")
                return
            }

            completion(response.content)
        }.resume()
    }
}
