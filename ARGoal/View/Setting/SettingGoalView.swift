//
//  SettingGoalView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/08/21.
//

import SwiftUI
import Combine

// MARK: - 目標設定

struct SettingGoalView: View {
    
    @ObservedObject var vm: ViewModel
        
    @Binding var tabSelection: Int
    
    @State var isActive: Bool = false
    @State var showAlert = false
        
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color(hex: ColorCode.background)
                    .edgesIgnoringSafeArea(.all)
                            
                VStack(spacing: 24) {
                    Image("goal")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                    
                    VStack(alignment: .center, spacing: 16) {
                        Text(Message.settingGoal)
                            .foregroundColor(Color(hex: ColorCode.theme))
                            .font(Font.custom(FontName.higaMaruProNW4, size: 20))
                        Text(Message.settingGoalDescription)
                            .foregroundColor(Color(hex: ColorCode.description))
                            .font(Font.custom(FontName.higaMaruProNW4, size: 12))
                            .lineSpacing(5)
                            .multilineTextAlignment(.center)
                    }
                    
                    TextField("", text: $vm.myGoal)
                        .frame(height: 60)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.horizontal, 10)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(hex: ColorCode.theme), lineWidth: 2))
                        .foregroundColor(Color(hex: ColorCode.theme))
                        .onReceive(Just(vm.myGoal)) { _ in
                            if vm.myGoal.count > MaxLength.myGoal {
                                vm.myGoal = String(vm.myGoal.prefix(MaxLength.myGoal))
                            }
                        }
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            guard !vm.myGoal.isEmpty
                                    && vm.myGoal.count <= MaxLength.myGoal else {
                                self.showAlert = true
                                return
                            }
                            self.isActive = true
                        }) {
                            NextButtonView()
                        }
                        .alert(isPresented: self.$showAlert) {
                            Alert(title: Text(""),
                                  message: Text(Message.settingGoalError),
                                  dismissButton: .default(Text(Message.close)))
                        }
                        
                        NavigationLink(destination: SettingPositionView(vm: vm,
                                                                        tabSelection: $tabSelection),
                                       isActive: self.$isActive) {
                            EmptyView()
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
