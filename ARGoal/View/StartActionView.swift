//
//  StartView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/23.
//

import SwiftUI

// MARK: - 開始

struct StartActionView: View {
    
    @State private var showMyGoal: Bool = false
    
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
                    .onTapGesture {
                        self.showMyGoal = true
                    }
                    .sheet(isPresented: self.$showMyGoal, content: {
                        ARViewContainer(vm: ViewModel())
                    })
            }
            .padding(.top, 100)
            .padding([.horizontal, .bottom], 16)
            .navigationBarHidden(true)
        }
    }
}
