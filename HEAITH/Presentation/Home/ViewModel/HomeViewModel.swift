//
//  HomeViewModel.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import Foundation
import Observation

@Observable
class HomeViewModel {
    var userentity: UserEntity = .init()
    var chartData: [Double] = [65.0, 64.5, 64.0, 63.5, 63.0]
}
