//
//  JournaliApp.swift
//  Journali
//
//  Created by Najla on 27/04/1447 AH.
//

import SwiftUI

@main
struct JournaliApp: App {
    @StateObject private var vm = JournalListViewModel()

    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(vm) // ✅ still inject VM so it works in MainPage later
        }
    }
}
