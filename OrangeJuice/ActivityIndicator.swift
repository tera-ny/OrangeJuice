//
//  ActivityIndicator.swift
//  OrangeJuice
//
//  Created by Haruta Yamada on 2021/04/24.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    let color: UIColor

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        let view = UIActivityIndicatorView(style: style)
        view.color = color
        return view
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
