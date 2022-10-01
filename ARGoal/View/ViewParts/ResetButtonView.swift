//
//  ResetButtonView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/10/01.
//

import SwiftUI

struct ResetButtonView: View {
    
    var body: some View {
        HStack {
            Text("リセット")
                .font(Font.custom(FontName.higaMaruProNW4, size: 16))
        }
        .foregroundColor(Color(hex: ColorCode.theme))
    }
}


