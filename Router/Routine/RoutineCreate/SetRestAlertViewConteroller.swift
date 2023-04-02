//
//  SetRestAlertViewConteroller.swift
//  Router
//
//  Created by Gilgim on 2023/03/25.
//

//  휴식 및 운동세트를 정하기 위한 ViewController입니다.
import Foundation
import SwiftUI
import UIKit
import SnapKit
import Combine


class SetRestAlertViewController: UIViewController {
    /// 알림 뷰
    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 13
        return view
    }()
    /// 알림 타이틀
    let viewTitle: UILabel = {
        let label = UILabel()
        label.text = "세트 및 휴식 설정"
        label.font = .systemFont(ofSize: 15, weight: .semibold, width: .standard)
        return label
    }()
    /// X 표시
    let xButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "xmark"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    /// 확인버튼
    let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular, width: .standard)
        return button
    }()
    /// 취소버튼
    let cancelButton: UIButton = {
        let button = UIButton()
        return button
    }()
    /// 세트 타이틀
    let setTitle: UILabel = {
        let label = UILabel()
        label.text = "세트"
        label.font = .systemFont(ofSize: 14, weight: .semibold, width: .standard)
        return label
    }()
    /// 이미 설정되어 있는 세트
    let beforeSetTitle: UILabel = {
        let label = UILabel()
        label.text = "이전 세트 : "
        label.font = .systemFont(ofSize: 12, weight: .medium, width: .standard)
        label.textColor = .systemGray
        return label
    }()
    let beforeSetInt: Int16
    /// 세트 텍스트 필드
    let setField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 20, weight: .bold, width: .standard)
        textField.textAlignment = .center
        return textField
    }()
    /// 휴식 타이틀
    let restTitle: UILabel = {
        let label = UILabel()
        label.text = "휴식"
        label.font = .systemFont(ofSize: 14, weight: .semibold, width: .standard)
        return label
    }()
    /// 이미 설정되어 있는 휴식
    let beforeRestTitle: UILabel = {
        let label = UILabel()
        label.text = "이전 휴식 : "
        label.font = .systemFont(ofSize: 12, weight: .medium, width: .standard)
        label.textColor = .systemGray
        return label
    }()
    let beforeRestInt: Int16
    /// 휴식 텍스트 필드
    let restField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 20, weight: .bold, width: .standard)
        textField.textAlignment = .center
        return textField
    }()
    var closure: () -> () = {}
    let setPublisher: PassthroughSubject<Int16, Never>
    let restPublisher: PassthroughSubject<Int16, Never>
    //  호출된 뷰의 세트와 휴식을 넘겨주기 위한 초기화
    init(closure: @escaping () -> (), setPublisher: PassthroughSubject<Int16, Never>, restPublisher: PassthroughSubject<Int16, Never>, beforeSetInt: Int16, beforeRestInt: Int16) {
        self.closure = closure
        self.setPublisher = setPublisher
        self.restPublisher = restPublisher
        self.beforeSetInt = beforeSetInt
        self.beforeRestInt = beforeRestInt
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        let notAction = UITapGestureRecognizer(target: self, action: #selector(notAction))
        self.view.addGestureRecognizer(notAction)
        
        self.setField.delegate = self
        self.setField.keyboardType = .numberPad
        
        self.restField.delegate = self
        self.restField.keyboardType = .numberPad
        self.viewSetting()
    }
    override func viewDidDisappear(_ animated: Bool) {
        closure()
    }
    /// 뷰를 세팅하는 함수
    private func viewSetting() {
        //  알럿 뷰
        let action = UITapGestureRecognizer(target: self, action: #selector(notAction))
        self.alertView.addGestureRecognizer(action)
        self.view.addSubview(alertView)
        self.alertView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.centerY.equalToSuperview()
        }
        //  타이틀 설정
        self.alertView.addSubview(viewTitle)
        viewTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.centerX.equalToSuperview()
        }
        //  x 표시
        self.alertView.addSubview(xButton)
        xButton.addTarget(self, action: #selector(dismissAlertView), for: .touchUpInside)
        xButton.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.top)
            make.leading.equalTo(12)
        }
        //  세트 타이틀 설정
        self.alertView.addSubview(setTitle)
        setTitle.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        //  사용자가 이미 설정핸둔 세트 타이틀
        self.alertView.addSubview(beforeSetTitle)
        self.beforeSetTitle.text = self.beforeSetTitle.text! + "\(beforeSetInt)"
        beforeSetTitle.snp.makeConstraints { make in
            make.top.equalTo(setTitle.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        //  사용자가 이미 설정핸둔 세트 타이틀
        self.alertView.addSubview(setField)
        setField.snp.makeConstraints { make in
            make.top.equalTo(beforeSetTitle.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalTo(beforeSetTitle.snp.leading)
            let setLabel: UILabel = {
                let label = UILabel()
                label.text = "세트"
                label.font = .systemFont(ofSize: 18, weight: .bold, width: .standard)
                return label
            }()
            self.setField.addSubview(setLabel)
            setLabel.snp.makeConstraints { make in
                make.leading.equalTo(setField.snp.trailing).offset(10)
                make.centerY.equalToSuperview()
            }
        }
        //  휴식 타이틀 설정
        self.alertView.addSubview(restTitle)
        restTitle.snp.makeConstraints { make in
            make.top.equalTo(setField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        //  사용자가 이미 설정핸둔 휴식 타이틀
        self.alertView.addSubview(beforeRestTitle)
        self.beforeRestTitle.text = self.beforeRestTitle.text! + "\(beforeRestInt) 초"
        beforeRestTitle.snp.makeConstraints { make in
            make.top.equalTo(restTitle.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
//          사용자가 이미 설정핸둔 휴식 타이틀
        self.alertView.addSubview(restField)
        restField.snp.makeConstraints { make in
            make.top.equalTo(beforeRestTitle.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalTo(beforeRestTitle.snp.leading)
            let restLabel: UILabel = {
                let label = UILabel()
                label.text = "초"
                label.font = .systemFont(ofSize: 18, weight: .bold, width: .standard)
                return label
            }()
            self.restField.addSubview(restLabel)
            restLabel.snp.makeConstraints { make in
                make.leading.equalTo(restField.snp.trailing).offset(10)
                make.centerY.equalToSuperview()
            }
        }
        
        self.alertView.addSubview(okButton)
        okButton.addTarget(self, action: #selector(okayAction), for: .touchUpInside)
        okButton.snp.makeConstraints { make in
            make.top.equalTo(restField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-4)
            
            let line = UIView()
            line.backgroundColor = .black.withAlphaComponent(0.1)
            self.alertView.addSubview(line)
            line.snp.makeConstraints { make in
                make.bottom.equalTo(okButton.snp.top)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(1)
            }
        }
    }
    @objc func okayAction() {
        self.setPublisher.send(Int16(setField.text ?? "0") ?? beforeSetInt)
        self.restPublisher.send(Int16(restField.text ?? "0") ?? beforeRestInt)
        self.dismiss(animated: true)
    }
    /// 현재 뷰를 사라지게하는 함수
    @objc func dismissAlertView() {
        self.dismiss(animated: true)
    }
    @objc func notAction() {
        setField.resignFirstResponder()
        restField.resignFirstResponder()
        
        self.alertView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.centerY.equalToSuperview()
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.alertView.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(50)
                make.trailing.equalToSuperview().offset(-50)
                make.bottom.equalToSuperview().offset(-(keyboardHeight+20))
            }
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
extension SetRestAlertViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.text != nil else {return true}
        if string == "" {
            textField.text?.removeLast()
        }
        else if Int(string) == nil {
            textField.text = ""
        }
        else {
            textField.text! += string
        }
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.alertView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.top.equalToSuperview().offset(180)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

struct AlertPreView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return SetRestAlertViewController(closure: {
            
        }, setPublisher: .init(), restPublisher: .init(), beforeSetInt: 5, beforeRestInt: 60)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    typealias UIViewControllerType = UIViewController

}
struct SetRestAlertView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AlertPreView()
            AlertPreView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
        }
    }
}
