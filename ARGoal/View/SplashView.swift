//
//  SplashView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/23.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isLoading = true

    var body: some View {
        
        if isLoading {
            ZStack(alignment: .center) {
                Color(hex: ColorCode.background)
                    .edgesIgnoringSafeArea(.all)
                Image("start")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        } else {
            // TODO: - 目標設定済みであれば設定画面へ遷移しない
            if UserDefaults.standard.object(forKey: "isGoalSet") != nil {
            } else {
                SettingGoalView()
            }
        }
    }
}
