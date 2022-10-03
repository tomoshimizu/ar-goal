//
//  StartView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/23.
//

import SwiftUI
import ARKit
import RealityKit

// MARK: - 開始

struct StartActionView: View {
    
    @ObservedObject var vm: ViewModel
    
    @Binding var tabSelection: Int
    
    @State private var showMyGoal: Bool = false
    
    @Environment(\.presentationMode) var presentation
    
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
                
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        BackButtonView()
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        vm.onClear()
                        
                        UserDefaults.standard.set(vm.myGoal, forKey: "myGoal")
                        
                        self.tabSelection = 0
                    }, label: {
                        StartButtonView()
                    })
                }
            }
            .padding(.top, 80)
            .padding([.horizontal, .bottom], 16)
            .navigationBarHidden(true)
        }
    }
}
