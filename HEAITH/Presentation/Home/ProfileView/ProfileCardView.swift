//
//  ProfileCardView.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import SwiftUI
import Observation

struct ProfileCardView: View {
    @Bindable var viewModel: HomeViewModel

    var body: some View {
        let user = viewModel.userentity

        VStack(alignment: .leading, spacing: 15) {
            Text("내 프로필")
                .font(.headline)

            HStack {
                Text("\(user.name)님")
                    .font(.caption)
            }

            HStack(spacing: 10) {
                genderButton(title: "남성", gender: .male)
                genderButton(title: "여성", gender: .female)
            }

            HStack {
                Text("나이: \(user.age)")
                Text("몸무게: \(user.weight, specifier: "%.1f")kg")
            }

            if user.bmi > 0 {
                Text("BMI: \(user.bmi, specifier: "%.2f")")
                    .font(.title3)
                    .foregroundColor(.blue)
                    .bold()
                    .padding(.top, 10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal)
    }

    private func genderButton(title: String, gender: UserEntity.Gender) -> some View {
        Button {
            viewModel.userentity.gender = gender
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.userentity.gender == gender ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(viewModel.userentity.gender == gender ? .white : .black)
                .cornerRadius(8)
        }
    }
}
