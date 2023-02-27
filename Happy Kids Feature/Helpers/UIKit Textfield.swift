//
//  Custom UIKit Textfield.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 27.02.2023.
//

import Foundation
import SwiftUI
import UIKit

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    let placeholderText: String
    let padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

    // padding, multiline, text binding, focus state, keypad, textfieldları değiştirme
    
    func makeUIView(context: Context) -> some UIView {
        let textfield = UITextField()
        textfield.delegate = context.coordinator
        textfield.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [.foregroundColor: UIColor.gray])
        textfield.layer.cornerRadius = 5.0
        textfield.layer.borderWidth = 4.0
        textfield.layer.borderColor = Color.UI_navBarColor.cgColor
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.spellCheckingType = .no

        return textfield
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    final class Coordinator: NSObject, UITextFieldDelegate {
        
        var parent: UITextFieldViewRepresentable
        
        init(_ parent: UITextFieldViewRepresentable) { self.parent = parent }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }

    }
 
}
