//
//  ContentView.swift
//  OrangeJuice
//
//  Created by Haruta Yamada on 2021/04/23.
//

import SwiftUI

struct ContentView: View {
    @State var urls: [URL] = []
    @State var isOpenPicker: Bool = false
    
    @Environment(\.uid) var uid
    @Environment(\.subscribedAuth) var isSubscribed

    var body: some View {
        TabView {
            NavigationView {
                if (isSubscribed) {
                    HomeView()
                } else {
                    EmptyView()
                }
            }.navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    VStack {
                        Image(systemName: "tv.music.note")
                        Text("Home")
                    }
                }
            NavigationView {
                if (isSubscribed) {
                    ContentsPickerView()
                } else {
                    EmptyView()
                }
            }.navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    VStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Upload")
                    }
                }
        }.fullScreenCover(isPresented: .constant(uid == nil && isSubscribed), content: {
            LoginView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
