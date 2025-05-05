//
//  AICoachButtonView.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//
import SwiftUI

struct AICoachButtonView: View {
    var body: some View {
        HStack {
            Image(systemName: "brain.head.profile")
            Text("AI 코치와 대화하기").bold()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
