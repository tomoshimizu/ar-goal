//
//  TimeEditPicker.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/13.
//

import SwiftUI

struct TimeEditPicker: View {
    
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        
        GeometryReader { geometry in
                            
            HStack(spacing: 20) {
                         
                Spacer()
                
                Picker("", selection: $vm.pushHour) {
                    ForEach((1..<24).reversed(), id: \.self) {
                        Text(String(format: "%02d", $0)).tag($0)
                    }
                }
                .accentColor(Color(hex: ColorCode.theme))
                
                Text(":")
                    .foregroundColor(Color(hex: ColorCode.theme))
                    .font(Font.custom(FontName.higaMaruProNW4, size: 20))
                
                Picker("", selection: $vm.pushMinute) {
                    ForEach((1..<59).reversed(), id: \.self) {
                        Text(String(format: "%02d", $0)).tag($0)
                    }
                }
                .accentColor(Color(hex: ColorCode.theme))
                
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width - (16 * 2), alignment: .center)
    }
}
