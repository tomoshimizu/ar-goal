//
//  StartView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/23.
//

import SwiftUI

/*
 TODO: -
 ・「はじめる」でランダム画面へ遷移（目標設定済みフラグで管理）
 */
/* 開始 */
struct StartActionView: View {
    
    var body: some View {
        
        ZStack(alignment: .center) {
            Color(hex: ColorCode.background)
                .edgesIgnoringSafeArea(.all)
                        
            VStack {
                Image("start")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                
                VStack(spacing: 16) {
                    Text(Message.startAction)
                        .foregroundColor(Color(hex: ColorCode.theme))
                        .font(Font.custom(FontName.higaMaruProNW4, size: 20))
                        .padding()
                    Text(Message.startActionDescription)
                        .foregroundColor(Color(hex: ColorCode.description))
                        .font(Font.custom(FontName.higaMaruProNW4, size: 12))
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                StartButtonView()
            }
            .navigationBarHidden(true)
            .padding(.top, 100)
            .padding([.horizontal, .bottom], 16)
        }
    }
}
