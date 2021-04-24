//
//  AuthObserver.swift
//  OrangeJuice
//
//  Created by Haruta Yamada on 2021/04/23.
//

import Foundation
import FirebaseAuth
import SwiftUI

class AuthObserver: ObservableObject {
    @Published var uid: String? = nil
    @Published var subscribed: Bool = false
    private var listener: AuthStateDidChangeListenerHandle!
    deinit {
        Auth.auth().removeStateDidChangeListener(listener)
        subscribed = false
    }
    init() {
        listener = Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            self?.subscribed = true
            self?.uid = user?.uid
        }
    }
}

private struct SubscribedAuthEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

private struct UIDEnvironmentKey: EnvironmentKey {
    static let defaultValue: String? = nil
}

extension EnvironmentValues {
    var uid: String? {
        get { self[UIDEnvironmentKey.self] }
        set { self[UIDEnvironmentKey.self] = newValue }
    }
    var subscribedAuth: Bool {
        get { self[SubscribedAuthEnvironmentKey.self] }
        set { self[SubscribedAuthEnvironmentKey.self] = newValue }
    }
}

