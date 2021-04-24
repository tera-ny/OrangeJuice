//
//  OrangeJuiceApp.swift
//  OrangeJuice
//
//  Created by Haruta Yamada on 2021/04/23.
//

import SwiftUI
import FirebaseAuth

@main
struct OrangeJuiceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var auth = AuthObserver()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.uid, auth.uid)
                .environment(\.subscribedAuth, auth.subscribed)
        }
    }
}
