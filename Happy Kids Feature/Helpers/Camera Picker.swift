//
//  Camera Picker.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 8.02.2023.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImageData: Data?
    @EnvironmentObject var hkViewModel: HKViewModel
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .camera
   
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
   
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
   
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
        var parent: ImagePicker
    
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
       
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: image)
                parent.selectedImageData = image.jpegData(compressionQuality: 1.0)!
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) { UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil) }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {}
}
