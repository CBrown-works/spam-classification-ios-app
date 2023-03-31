//
//  SpamSmsClassifierApplicationApp.swift
//  SpamSmsClassifierApplication
//
//  Created by Carlton Brown on 3/29/23.
//

import SwiftUI

@main
struct SpamSmsClassifierApplicationApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            ContentView().preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
