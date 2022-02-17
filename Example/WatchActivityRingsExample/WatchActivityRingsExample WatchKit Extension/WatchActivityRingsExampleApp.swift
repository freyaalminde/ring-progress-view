//
//  WatchActivityRingsExampleApp.swift
//  WatchActivityRingsExample WatchKit Extension
//
//  Created by Freya Ariel on 2/17/22.
//

import SwiftUI

@main
struct WatchActivityRingsExampleApp: App {
    var body: some Scene {
        WindowGroup {
//            NavigationView {
                ScrollView {
                    ContentView2()
                        .scaledToFit()
                    ContentView()
                        .scaledToFit()
                    ContentView()
                        .scaledToFit()
                    ContentView()
                        .scaledToFit()
                }
//                .tabViewStyle(.page)
//            }
        }
    }
}
