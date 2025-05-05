//
//  AICoachView.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import SwiftUI

struct AICoachView: View {
    @State private var message = "오늘 운동 추천해줘"
    @State private var response = ""

    var body: some View {
        VStack {
            Text("AI 피트니스 코치").font(.title)

            Text("입력: \(message)")
                .padding()

            Text("응답: \(response)")
                .padding()

            Button("AI에게 물어보기") {
                Task {
                    response = await fetchAIResponse(prompt: message)
                }
            }
        }
        .padding()
    }

    func fetchAIResponse(prompt: String) async -> String {
        guard let url = URL(string: "https://example.com/ai-coach") else { return "URL 오류" }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["prompt": prompt])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(AIResponse.self, from: data)
            return result.content
        } catch {
            return "에러: \(error.localizedDescription)"
        }
    }
}
