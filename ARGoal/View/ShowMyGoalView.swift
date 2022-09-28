//
//  ShowMyGoalView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/28.
//

import SwiftUI

struct ShowMyGoal: View {
    
    @State var showAlert = false
    
    @Environment(\.presentationMode) var presentation
    
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
                
                // TODO: - ARView
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.showAlert = true
                    }) {
                        ResetButtonView()
                    }
                    .alert(isPresented: self.$showAlert) {
                        Alert(title: Text(""),
                              message: Text(Message.resetConfirm),
                              primaryButton: .cancel(Text(Message.cancel)),
                              secondaryButton: .destructive(Text(Message.reset),
                                                            action: {
                            // TODO: - リセットする処理
                        }))
                    }
                    
                    Spacer()
                }
            }
            .padding(.top, 80)
            .padding([.horizontal, .bottom], 16)
            .navigationBarHidden(true)
        }
    }
}
