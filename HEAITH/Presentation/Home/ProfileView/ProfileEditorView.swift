//
//  ProfileEditorView.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import SwiftUI
import Observation

struct ProfileEditorView: View {
    @Bindable var viewModel: HomeViewModel

    var body: some View {
        let user = viewModel.userentity

        Form {
            Section(header: Text("기본 정보")) {
                TextField("이름", text: $viewModel.userentity.name)
                Stepper("나이: \(user.age)", value: $viewModel.userentity.age, in: 1...120)
                Stepper("몸무게: \(user.weight, specifier: "%.1f")kg", value: $viewModel.userentity.weight, in: 30...200, step: 0.5)
                Picker("성별", selection: $viewModel.userentity.gender) {
                    ForEach(UserEntity.Gender.allCases, id: \ .self) { gender in
                        Text(gender.rawValue)
                    }
                }
            }
        }
        .navigationTitle("프로필 설정")
    }
}
