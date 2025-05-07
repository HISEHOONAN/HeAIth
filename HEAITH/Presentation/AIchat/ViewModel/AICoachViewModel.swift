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
    var messages: [(String, Bool)] = []
    var input: String = ""
    
    private let aiService: AICoachService = .init()
    
    init() {}
    
    func sendMessage(_ text: String? = nil, isUser: Bool = true) {
        let message = text ?? input
        guard !message.isEmpty else { return }
        
        messages.append((message, isUser))
        
        if isUser {
            aiService.sendMessageToAI(message) { [weak self] response in
                DispatchQueue.main.async {
                    self?.messages.append((response, false))
                }
            }
            input = ""
        }
    }
}

