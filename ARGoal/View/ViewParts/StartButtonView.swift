//
//  StartButtonView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/12.
//

import SwiftUI

struct StartButtonView: View {
    
    var body: some View {
        HStack {
            Text(Message.confimGoal)
                .font(Font.custom(FontName.higaMaruProNW4, size: 20))
        }
        .frame(width: (UIScreen.main.bounds.width - (16 * 2)) / 2, height: 70, alignment: .center)
        .background(Color(hex: ColorCode.theme))
        .foregroundColor(Color.white)
        .cornerRadius(40)
    }
}
