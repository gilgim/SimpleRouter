//
//  RunningListScrollView.swift
//  Router
//
//  Created by Gilgim on 2023/04/02.
//

import Foundation
import SwiftUI
import UIKit
import SnapKit

struct RunningListScrollView<Content: View>: UIViewControllerRepresentable {
    let rootView: Content
    func makeUIViewController(context: Context) -> UIViewController {
        let customViewController = UIHostingController(rootView: rootView)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBlue
        let scrollView = UIScrollView()
        
        scrollView.isScrollEnabled = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.alwaysBounceVertical = false
        
        viewController.view.addSubview(scrollView)
        scrollView.addSubview(customViewController.view)
        
        customViewController.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalTo(customViewController.view.snp.trailing)
        }
        return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
struct RunningListScrollView_Previews: PreviewProvider {
    static var previews: some View {
        RunningListScrollView(rootView: HStack {
            Circle()
            Circle()
            Circle()
            Circle()
            Circle()
            Spacer()
        })
    }
}
