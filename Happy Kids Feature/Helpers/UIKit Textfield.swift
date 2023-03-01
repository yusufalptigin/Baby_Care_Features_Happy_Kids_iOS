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
    @Binding var textStyle: UIFont.TextStyle
    let keyboardType: UIKeyboardType
    
    func makeUIView(context: Context) -> UITextView {
        
        // Initialize
        let textfield = UITextView()
        textfield.delegate = context.coordinator
        textfield.keyboardType = keyboardType
        textfield.text = text
        
        // Style
        textfield.font = UIFont.preferredFont(forTextStyle: textStyle)
        textfield.textColor = UIColor.black
        textfield.layer.cornerRadius = 5.0
        textfield.layer.borderWidth = 4.0
        textfield.layer.borderColor = Color.UI_navBarColor.cgColor
        textfield.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        
        // Interactions
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.spellCheckingType = .no
        textfield.isSelectable = true
        textfield.isUserInteractionEnabled = true
        
        // Toolbar
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Bitti", style: .plain, target: textfield, action: #selector(textfield.endEditing(_:)))
        doneButton.tintColor = Color.UI_navBarColor
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        textfield.inputAccessoryView = toolbar

        return textfield
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: UITextFieldViewRepresentable
        
        init(_ parent: UITextFieldViewRepresentable) { self.parent = parent }
        
        func textViewDidChange(_ textView: UITextView) { parent.text = textView.text }
        
    }
}


