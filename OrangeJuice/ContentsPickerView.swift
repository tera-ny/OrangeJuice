//
//  PickContentsView.swift
//  OrangeJuice
//
//  Created by Haruta Yamada on 2021/04/23.
//

import SwiftUI
import AVFoundation

struct ContentsPickerView: View {
    @State var urls: [URL] = []
    @State var isOpenPicker: Bool = true
    @ObservedObject var viewModel = ContentsPickerViewModel()
    var body: some View {
        ZStack {
            if urls.isEmpty {
                VStack(spacing: 20) {
                    Text("アップロードするファイルを選択してください")
                    Button(action: {
                        isOpenPicker = true
                        viewModel.stop()
                    }, label: {
                        Text("Select")
                    })
                }
            } else {
                List {
                    ForEach(urls) { url in
                        HStack(content: {
                            Text(url.lastPathComponent)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            Spacer()
                            Button(action: {
                                if (viewModel.isPlaying(url: url)) {
                                    viewModel.pause()
                                } else {
                                    viewModel.play(url: url)
                                }
                            }, label: {
                                Image(systemName: viewModel.isPlaying(url: url) ? "pause.fill" : "play.fill")
                                    .foregroundColor(.orange)
                                    .padding(7)
                            }).buttonStyle(BlurButtonStyle())
                        })
                    }
                    .onDelete(perform: removeURL(_:))
                }
            }
        }.sheet(isPresented: $isOpenPicker, content: {
            DocumentPickerView(urls: $urls)
                .ignoresSafeArea()
        })
            .navigationBarItems(trailing:
                NavigationLink(
                    destination: UploaderView(),
                    label: {
                        Text("アップロード")
                    }).disabled(urls.isEmpty)
            )
            .navigationBarTitle("Upload")
    }
    
    func removeURL(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let removedURL = urls.remove(at: index)
            if viewModel.isPlaying(url: removedURL) {
                viewModel.stop()
            }
        }
    }
}

struct PickContentsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ContentsPickerView(urls: [URL(string: "/hogehoge/piyopiyo/fuga.wav")!], isOpenPicker: false)
            }.navigationViewStyle(StackNavigationViewStyle())
            ContentsPickerView(urls: [], isOpenPicker: false)
        }
    }
}
