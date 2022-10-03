//
//  ShowMyGoalView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/28.
//

import SwiftUI

struct ShowMyGoalView: View {
        
    @ObservedObject var vm: ViewModel
    
    @Binding var tabSelection: Int
    
    @State var showResetAlert = false

    var body: some View {
        
        ZStack {
            Color(hex: ColorCode.background)
                .edgesIgnoringSafeArea(.all)
                        
            VStack(spacing: 24) {
                
                VStack(alignment: .center, spacing: 16) {
                    
                    if UserDefaults.standard.bool(forKey: "goalWasSet") {
                        Text(Message.showMyGoal)
                            .foregroundColor(Color(hex: ColorCode.theme))
                            .font(Font.custom(FontName.higaMaruProNW4, size: 20))
                        Text(Message.showMyGoalDescription)
                            .foregroundColor(Color(hex: ColorCode.description))
                            .font(Font.custom(FontName.higaMaruProNW4, size: 12))
                            .lineSpacing(5)
                            .multilineTextAlignment(.center)
                    } else {
                        Text(Message.settingPosition)
                            .foregroundColor(Color(hex: ColorCode.theme))
                            .font(Font.custom(FontName.higaMaruProNW4, size: 20))
                        Text(Message.settingPositionDescription)
                            .foregroundColor(Color(hex: ColorCode.description))
                            .font(Font.custom(FontName.higaMaruProNW4, size: 12))
                            .lineSpacing(5)
                            .multilineTextAlignment(.center)
                    }
                }
                
                ARViewContainer(vm: vm)

                HStack {
                    Spacer()
                    Button("保存") {
                        vm.onSave()
                    }.buttonStyle(.borderedProminent)
                }
                .alert("保存されました", isPresented: $vm.isSaved) {
                    Button("OK") {
                        UserDefaults.standard.set(vm.myGoal, forKey: "myGoal")
                        UserDefaults.standard.set(true, forKey: "goalWasSet")
                    }
                }
            }
            .padding(.top, 80)
            .padding([.horizontal, .bottom], 16)
            .navigationBarHidden(true)
        }
    }
}
