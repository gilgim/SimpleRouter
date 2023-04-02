//
//  ScrollViewWrapper.swift
//  Router
//
//  Created by Gilgim on 2023/04/02.
//

import Foundation
import SwiftUI
import SnapKit

struct ScrollViewWrapper<Content: View>: UIViewRepresentable {
    var content: Content
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let contentView = UIHostingController(rootView: content)
        scrollView.delegate = context.coordinator
        scrollView.addSubview(contentView.view)
        contentView.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        for view in uiView.subviews {
            view.removeFromSuperview()
        }
        let contentView = UIHostingController(rootView: content)
        uiView.addSubview(contentView.view)
        contentView.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    class Coordinator: NSObject,UIScrollViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            print("asdf")
        }
    }
}

