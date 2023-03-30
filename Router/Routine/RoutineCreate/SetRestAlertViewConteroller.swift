//
//  SetRestAlertViewConteroller.swift
//  Router
//
//  Created by Gilgim on 2023/03/25.
//

//  휴식 및 운동세트를 정하기 위한 ViewController입니다.
import Foundation
import UIKit
import SnapKit
import Combine


class SetRestAlertViewController: UIViewController {
    let height = UIScreen.main.bounds.height
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
        label.font = .systemFont(ofSize: UIScreen.main.bounds.height * 0.021, weight: .semibold, width: .standard)
        return label
    }()
    /// 확인버튼
    let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIScreen.main.bounds.height * 0.018, weight: .regular, width: .standard)
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
        label.font = .systemFont(ofSize: UIScreen.main.bounds.height * 0.019, weight: .semibold, width: .standard)
        return label
    }()
    /// 이미 설정되어 있는 세트
    let beforeSetTitle: UILabel = {
        let label = UILabel()
        label.text = "이전 세트 : "
        label.font = .systemFont(ofSize: UIScreen.main.bounds.height * 0.017, weight: .medium, width: .standard)
        label.textColor = .systemGray
        return label
    }()
    let beforeSetInt: Int16
    /// 세트 텍스트 필드
    let setField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: UIScreen.main.bounds.height * 0.032, weight: .bold, width: .standard)
        textField.textAlignment = .center
        return textField
    }()
    /// 휴식 타이틀
    let restTitle: UILabel = {
        let label = UILabel()
        label.text = "휴식"
        label.font = .systemFont(ofSize: UIScreen.main.bounds.height * 0.019, weight: .semibold, width: .standard)
        return label
    }()
    /// 이미 설정되어 있는 휴식
    let beforeRestTitle: UILabel = {
        let label = UILabel()
        label.text = "이전 휴식 : "
        label.font = .systemFont(ofSize: UIScreen.main.bounds.height * 0.017, weight: .medium, width: .standard)
        label.textColor = .systemGray
        return label
    }()
    let beforeRestInt: Int16
    /// 휴식 텍스트 필드
    let restField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: UIScreen.main.bounds.height * 0.032, weight: .bold, width: .standard)
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
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        let dismissAction = UITapGestureRecognizer(target: self, action: #selector(dismissAlertView))
        self.view.addGestureRecognizer(dismissAction)
        self.setField.delegate = self
        self.restField.delegate = self
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
            make.height.equalTo(height*0.51)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        //  타이틀 설정
        self.alertView.addSubview(viewTitle)
        viewTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(height*0.024)
            make.centerX.equalToSuperview()
        }
        //  세트 타이틀 설정
        self.alertView.addSubview(setTitle)
        setTitle.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(height*0.048)
            make.centerX.equalToSuperview()
        }
        //  사용자가 이미 설정핸둔 세트 타이틀
        self.alertView.addSubview(beforeSetTitle)
        self.beforeSetTitle.text = self.beforeSetTitle.text! + "\(beforeSetInt)"
        beforeSetTitle.snp.makeConstraints { make in
            make.top.equalTo(setTitle.snp.bottom).offset(height*0.009)
            make.centerX.equalToSuperview()
        }
        //  사용자가 이미 설정핸둔 세트 타이틀
        self.alertView.addSubview(setField)
        setField.snp.makeConstraints { make in
            make.top.equalTo(beforeSetTitle.snp.bottom).offset(height*0.014)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(110)
            make.trailing.equalToSuperview().inset(110)
            
            let setLabel: UILabel = {
                let label = UILabel()
                label.text = "세트"
                label.font = .systemFont(ofSize: 18, weight: .bold, width: .standard)
                return label
            }()
            self.setField.addSubview(setLabel)
            setLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(setField.snp.trailing).offset(10)
            }
        }
        //  휴식 타이틀 설정
        self.alertView.addSubview(restTitle)
        restTitle.snp.makeConstraints { make in
            make.top.equalTo(setField.snp.bottom).offset(height*0.048)
            make.centerX.equalToSuperview()
        }
        //  사용자가 이미 설정핸둔 휴식 타이틀
        self.alertView.addSubview(beforeRestTitle)
        self.beforeRestTitle.text = self.beforeRestTitle.text! + "\(beforeRestInt) 초"
        beforeRestTitle.snp.makeConstraints { make in
            make.top.equalTo(restTitle.snp.bottom).offset(height*0.009)
            make.centerX.equalToSuperview()
        }
//          사용자가 이미 설정핸둔 휴식 타이틀
        self.alertView.addSubview(restField)
        restField.snp.makeConstraints { make in
            make.top.equalTo(beforeRestTitle.snp.bottom).offset(height*0.024)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(110)
            make.trailing.equalToSuperview().inset(110)
            
            let restLabel: UILabel = {
                let label = UILabel()
                label.text = "초"
                label.font = .systemFont(ofSize: 18, weight: .bold, width: .standard)
                return label
            }()
            self.restField.addSubview(restLabel)
            restLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(restField.snp.trailing).offset(10)
            }
        }
        
        self.alertView.addSubview(okButton)
        okButton.addTarget(self, action: #selector(okayAction), for: .touchUpInside)
        okButton.snp.makeConstraints { make in
            make.top.equalTo(restField.snp.bottom).offset(height*0.048)
            make.bottom.equalTo(self.alertView.snp.bottom).inset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()

            let line = UIView()
            line.backgroundColor = .black.withAlphaComponent(0.1)
            self.alertView.addSubview(line)
            line.snp.makeConstraints { make in
                make.bottom.equalTo(okButton.snp.top).offset(-5)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.alertView.snp.remakeConstraints { make in
            make.height.equalTo(height*0.51)
            make.bottom.equalToSuperview().offset(-height*0.41)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.alertView.snp.remakeConstraints { make in
            make.height.equalTo(height*0.51)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
