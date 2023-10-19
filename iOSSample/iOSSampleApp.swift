//
//  iOSSampleApp.swift
//  iOSSample
//
//  Created by Chandra Hasan on 17/10/23.
//

import SwiftUI

@main
struct iOSSampleApp: App {
    var body: some Scene {
        WindowGroup {
            let key = UserDefaults.standard.bool(forKey: "isLogin")
            if(key == nil || !key) {
                ContentView().preferredColorScheme(.light)
            } else {
                DashBoardView().preferredColorScheme(.light)
            }
        }
    }
}
