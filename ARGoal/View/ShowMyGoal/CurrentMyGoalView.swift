//
//  CurrentMyGoal.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/10/06.
//

import SwiftUI
import Combine

// MARK: - 現在の目標

struct CurrentMyGoalView: View {
    
    @ObservedObject var vm: ViewModel
        
    @Binding var tabSelection: Int
    
    @State var showResetAlert = false;
        
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color(hex: ColorCode.background)
                    .edgesIgnoringSafeArea(.all)
                            
                VStack(spacing: 24) {
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 16) {
                        Text("現在設定されている目標")
                            .foregroundColor(Color(hex: ColorCode.theme))
                            .font(Font.custom(FontName.higaMaruProNW4, size: 20))
                        Text(UserDefaults.standard.string(forKey: "myGoal") ?? "")
                            .foregroundColor(Color(hex: "fa8072"))
                            .font(Font.custom(FontName.higaMaruProNW4, size: 30))
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            showResetAlert = true;
                        }){
                            Text("目標をリセット")
                        }.buttonStyle(.borderedProminent)

                        .alert("確認", isPresented: $showResetAlert) {
                            Button("キャンセル", role: .cancel) {
                            }
                            Button("リセット", role: .destructive) {
                                vm.onClear()
                            }
                        } message: {
                            Text("目標をリセットしますか？")
                        }
                    }
                }
                .padding(.top, 80)
                .padding([.horizontal, .bottom], 16)
                .navigationBarHidden(true)
            }
        }
    }
}
