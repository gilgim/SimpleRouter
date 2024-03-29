//
//  UIRepresentable.swift
//  SimpleRoutine
//
//  Created by Gilgim on 2023/04/26.
//

import Foundation
import UIKit
import SwiftUI
import Combine

struct CustomTextField: UIViewRepresentable {
    @State var cancellables = Set<AnyCancellable>()
    @Binding var text: String
    var placeholder: String?
    var isFocus: PassthroughSubject<Bool, Never>?
    var isCommit = PassthroughSubject<Bool, Never>()
    var commitAction: ()->()
    
    init(_ placeholder: String? = nil, text: Binding<String>, isFocus: PassthroughSubject<Bool, Never>? = nil, commitAction: @escaping ()->() = {}) {
        self._text = text
        self.placeholder = placeholder
        self.isFocus = isFocus
        self.commitAction = commitAction
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        
        textField.placeholder = self.placeholder
        textField.font = .boldSystemFont(ofSize: 18)
        textField.textColor = .white
        textField.tintColor = .white
        
        DispatchQueue.main.async {
            self.isFocus?.sink(receiveValue: { value in
                if value {
                    textField.becomeFirstResponder()
                }
            }).store(in: &cancellables)
            
            self.isCommit.sink(receiveValue: { value in
                if value {
                    self.commitAction()
                }
            }).store(in: &cancellables)
        }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if text == "" {
            uiView.text = ""
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var customTextField: CustomTextField
        init(_ customTextField: CustomTextField) {
            self.customTextField = customTextField
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if isBackSpace == -92 && !(self.customTextField.text.isEmpty) {
                    return true
                }
            }
            if let text = textField.text {
                DispatchQueue.main.async {
                    self.customTextField.text = text+string
                }
            }
            return true
        }
        func textFieldDidChangeSelection(_ textField: UITextField) {
            if let text = textField.text {
                DispatchQueue.main.async {
                    self.customTextField.text = text
                }
            }
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.customTextField.isCommit.send(true)
            return false
        }
    }
}
