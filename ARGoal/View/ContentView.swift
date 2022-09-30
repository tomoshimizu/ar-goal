//
//  ContentView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/30.
//

import SwiftUI

struct ContentView: View {
    
    @State var tabSelection = 0
    
    var body: some View {
        
        TabView(selection: $tabSelection) {
            ShowMyGoalView()
                .tabItem {
                    VStack {
                        Image("eye")
                            .renderingMode(.template)
                        Text(Message.confimGoal)
                    }
            }.tag(0)
            
            SettingGoalView(tabSelection: $tabSelection)
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
