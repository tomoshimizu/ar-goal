//
//  NextButtonView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/10.
//

import SwiftUI

struct NextButtonView: View {
    
    var body: some View {
        HStack {
            Text(Message.next)
                .font(Font.custom(FontName.higaMaruProNW4, size: 20))
            Image(systemName: "arrow.right")
                .frame(width: 30, height: 30)
        }
        .frame(width: (UIScreen.main.bounds.width - (16 * 2)) / 2, height: 70, alignment: .center)
        .background(Color(hex: ColorCode.theme))
        .foregroundColor(Color.white)
        .cornerRadius(40)
    }
}
