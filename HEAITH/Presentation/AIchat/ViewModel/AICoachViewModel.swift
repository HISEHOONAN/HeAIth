//
//  AICoachViewModel.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//


import Foundation
import Observation

@Observable
class AICoachViewModel {
    var messages: [String] = ["AI: 운동 계획을 도와드릴까요?"]
    var input: String = ""

    private let aiService: AICoachService = .init()

    func sendMessage() {
        guard !input.isEmpty else { return }
        messages.append("나: \(input)")

        aiService.sendMessageToAI(input) { [weak self] response in
            DispatchQueue.main.async {
                self?.messages.append("AI: \(response)")
            }
        }

        input = ""
    }
}
