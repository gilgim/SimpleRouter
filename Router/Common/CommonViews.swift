//
//  CommonViews.swift
//  Router
//
//  Created by Gaea on 2023/04/05.
//

import Foundation
import UIKit
import SnapKit
import Combine

class PauseViewController: UIViewController {
    let restartPublisher = PassthroughSubject<Bool,Never>()
    let pauseLabel: UILabel = {
        let label = UILabel()
        label.text = "일시정지"
        label.font = .systemFont(ofSize: 20, weight: .semibold, width: .standard)
        label.textColor = .white
        return label
    }()
    let touchGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "터치하여 일시정지 해제"
        label.font = .systemFont(ofSize: 15, weight: .regular, width: .standard)
        label.textColor = .white
        return label
    }()
    override func viewDidLoad() {
        self.view.backgroundColor = .black.withAlphaComponent(0.7)
        let action = UITapGestureRecognizer(target: self, action: #selector(restartAction))
        self.view.addGestureRecognizer(action)
        
        self.view.addSubview(pauseLabel)
        pauseLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.view.addSubview(touchGuideLabel)
        self.touchGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(pauseLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    @objc func restartAction() {
        restartPublisher.send(true)
        self.dismiss(animated: true)
    }
}
