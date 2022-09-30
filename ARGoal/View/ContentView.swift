//
//  ContentView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/30.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = ViewModel()
    
    @State var tabSelection = UserDefaults.standard.object(forKey: "myGoal") != nil ? 0 : 1
    
    var body: some View {
        
        TabView(selection: $tabSelection) {
            ShowMyGoalView(vm: vm)
                .tabItem {
                    VStack {
                        Image("eye")
                            .renderingMode(.template)
                        Text(Message.confimGoal)
                    }
            }.tag(0)
            
            SettingGoalView(vm: vm,
                            tabSelection: $tabSelection)
                .tabItem {
                    VStack {
                        Image("setting")
                            .renderingMode(.template)
                        Text(Message.setting)
                    }
            }.tag(1)
        }
        .accentColor(Color(hex: ColorCode.accent))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
