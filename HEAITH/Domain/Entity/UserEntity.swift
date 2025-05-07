//
//  UserEntity.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import Foundation
import Observation

@Observable
class UserEntity {
    var name: String = "세훈"
    var gender: Gender = .male
    var age: Int = 25
    var weight: Double = 70.0

    enum Gender: String, CaseIterable, Identifiable {
        case male = "남성"
        case female = "여성"

        var id: String { rawValue }
    }

    var bmi: Double {
        weight / (1.75 * 1.75)
    }
}

extension UserEntity {
    var aiPromptSummary: String {
        return """
        이름: \(name)
        성별: \(gender.rawValue)
        나이: \(age)세
        체중: \(weight)kg
        BMI: \(String(format: "%.2f", bmi))
        """
    }
}
