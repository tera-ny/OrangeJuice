//
//  DocumentPickerView.swift
//  OrangeJuice
//
//  Created by Haruta Yamada on 2021/04/23.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct DocumentPickerView: UIViewControllerRepresentable {
    @Binding var urls: [URL]
    func makeCoordinator() -> Coordinator {
        .init(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentPickerView
        init(_ view: DocumentPickerView) {
            parent = view
        }

        func documentPicker(_: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.urls = urls
        }

        func documentPickerWasCancelled(_: UIDocumentPickerViewController) {
            print("キャンセル")
        }
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let vc = UIDocumentPickerViewController(forOpeningContentTypes: [.video, .audio, .movie], asCopy: true)
        vc.delegate = context.coordinator
        vc.allowsMultipleSelection = true
        return vc
    }

    func updateUIViewController(_: UIDocumentPickerViewController, context _: Context) {}
}
