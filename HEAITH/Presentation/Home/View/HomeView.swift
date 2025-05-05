//
//  HomeView.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HeaderView(title: "AI 피트니스 코치")

                    ProfileCardView(viewModel: viewModel)

                    WeightChartView(data: viewModel.chartData)

                    NavigationLink(destination: AICoachChatView(viewModel: AICoachViewModel())) {
                        AICoachButtonView()
                    }

                    NavigationLink(destination: ProfileEditorView(viewModel: viewModel)) {
                        Text("프로필 편집")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    NavigationLink(destination: ExerciseSaveView()) {
                        Text("운동 기록")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom)
            }
            .background(Color(.systemGray6))
        }
    }
}





#Preview {
    HomeView()
}
