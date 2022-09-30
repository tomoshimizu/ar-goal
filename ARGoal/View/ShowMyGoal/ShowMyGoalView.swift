//
//  ShowMyGoalView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/28.
//

import SwiftUI

struct ShowMyGoalView: View {
        
    @ObservedObject var vm: ViewModel
    
    @State var showAlert = false
        
    var body: some View {
        
        ZStack {
            Color(hex: ColorCode.background)
                .edgesIgnoringSafeArea(.all)
                        
            VStack(spacing: 24) {
                
                VStack(alignment: .center, spacing: 16) {
                    Text(Message.showMyGoal)
                        .foregroundColor(Color(hex: ColorCode.theme))
                        .font(Font.custom(FontName.higaMaruProNW4, size: 20))
                    Text(Message.showMyGoalDescription)
                        .foregroundColor(Color(hex: ColorCode.description))
                        .font(Font.custom(FontName.higaMaruProNW4, size: 12))
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                }
                
                ARViewContainer(vm: vm)
                    .onAppear(perform: {
                        vm.onLoad()
                    })
            }
            .padding(.top, 80)
            .padding([.horizontal, .bottom], 16)
            .navigationBarHidden(true)
        }
    }
}
