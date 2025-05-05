//
//  AICoachService.swift
//  HEAITH
//
//  Created by 안세훈 on 5/5/25.
//

import Foundation

final class AICoachService {
    func sendMessageToAI(_ message: String, completion: @escaping (String) -> Void) {
        
        guard let url = URL(string: "https://your-ai-api.com/chat") else {
            completion("URL 오류")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["message": message]
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion("에러: \(error.localizedDescription)")
                return
            }

            guard let data = data,
                  let response = try? JSONSerialization.jsonObject(with: data) as? [String: String],
                  let reply = response["response"] else {
                completion("응답 파싱 실패")
                return
            }

            completion(reply)
        }.resume()
    }
}
