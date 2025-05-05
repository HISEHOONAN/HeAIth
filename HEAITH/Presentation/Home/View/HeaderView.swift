//
//  HeaderView.swift
//  HEAITH
//
//  Created by 안세훈 on 4/30/25.
//

import SwiftUI

struct HeaderView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.largeTitle).bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
}
