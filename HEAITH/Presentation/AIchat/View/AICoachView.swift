//
//  AICoachView.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import SwiftUI

struct AICoachView: View {
    @State private var viewModel = AICoachViewModel()

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(viewModel.messages.indices, id: \.self) { index in
                        let (text, isUser) = viewModel.messages[index]
                        HStack {
                            if isUser {
                                Spacer()
                                Text(text)
                                    .padding()
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                                    .frame(maxWidth: 250, alignment: .trailing)
                            } else {
                                Text(text)
                                    .padding()
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(10)
                                    .frame(maxWidth: 250, alignment: .leading)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }

            // 입력 필드
            HStack {
                TextField("메시지를 입력하세요", text: $viewModel.input)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("보내기") {
                    viewModel.sendMessage()
                }
            }
            .padding()
        }
        .navigationTitle("AI 코치")
    }
}

