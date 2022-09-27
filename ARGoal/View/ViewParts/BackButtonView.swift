//
//  BackButtonView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/23.
//

import SwiftUI

struct BackButtonView: View {
    
    var body: some View {
        HStack {
            Text(Message.back)
                .font(Font.custom(FontName.higaMaruProNW4, size: 20))
        }
        .foregroundColor(Color(hex: ColorCode.theme))
    }
}
