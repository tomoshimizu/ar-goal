//
//  SettingNotificationView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/10.
//

import SwiftUI
import UserNotifications

// MARK: - 通知設定

struct SettingNotificationView: View {
    
    @ObservedObject var vm: ViewModel
    
    @Binding var tabSelection: Int
        
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        ZStack {
            Color(hex: ColorCode.background)
                .edgesIgnoringSafeArea(.all)
                        
            VStack(spacing: 24) {
                Image("notification")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                
                VStack(alignment: .center, spacing: 16) {
                    Text(Message.settingNotification)
                        .foregroundColor(Color(hex: ColorCode.theme))
                        .font(Font.custom(FontName.higaMaruProNW4, size: 20))
                        .padding()
                    Text(Message.settingNotificationDescription)
                        .foregroundColor(Color(hex: ColorCode.description))
                        .font(Font.custom(FontName.higaMaruProNW4, size: 12))
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                }

                TimeEditPicker(vm: vm)
                
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        BackButtonView()
                    })
                    
                    Spacer()
                    
                    NavigationLink(destination: StartActionView(vm: vm,
                                                                tabSelection: $tabSelection)) {
                        NextButtonView()
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        vm.setPushNotification()
                    })
                }
            }
            .padding(.top, 80)
            .padding([.horizontal, .bottom], 16)
            .navigationBarHidden(true)
        }
    }
}

