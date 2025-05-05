//
//  WeightChartView.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import SwiftUI
import Charts

struct WeightChartView: View {
    let data: [Double]

    var body: some View {
        VStack(alignment: .leading) {
            Text("체중 변화 추이")
                .font(.headline)
                .padding(.bottom, 5)

            Chart {
                ForEach(Array(data.enumerated()), id: \ .offset) { index, value in
                    LineMark(
                        x: .value("Month", index + 1),
                        y: .value("Weight", value)
                    )
                }
            }
            .frame(height: 200)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}
