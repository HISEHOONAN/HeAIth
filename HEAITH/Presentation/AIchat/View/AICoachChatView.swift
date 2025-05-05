//
//  AICoachChatView.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import SwiftUI

struct AICoachChatView: View {
    @Bindable var viewModel: AICoachViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.messages, id: \ .self) { msg in
                        Text(msg).padding(6).background(Color.gray.opacity(0.1)).cornerRadius(8)
                    }
                }.padding()
            }

            HStack {
                TextField("메시지를 입력하세요", text: $viewModel.input)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("보내기") {
                    viewModel.sendMessage()
                }
            }.padding()
        }
        .navigationTitle("AI 코치")
    }
}
