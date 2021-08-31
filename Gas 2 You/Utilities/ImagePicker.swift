//
//  ImagePicker.swift
//  Virtuwoof Pet
//
//  Created by EWW80 on 13/11/19.
//  Copyright © 2019 EWW80. All rights reserved.
//

import Foundation
import AVFoundation
import Photos
import UIKit

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage? , button : Int)
}


open class ImagePicker: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate, allowsEditing : Bool) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = allowsEditing
        
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String , tag : Int) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.pickerController.view.tag = tag
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView , image : UIImage) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take photo", tag: sourceView.tag) {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll", tag: sourceView.tag) {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library", tag: sourceView.tag) {
            alertController.addAction(action)
        }
       
        if  image == UserPlaceHolder{
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                alertController.popoverPresentationController?.sourceView = sourceView
                alertController.popoverPresentationController?.sourceRect = sourceView.bounds
                alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
            }
            self.presentationController?.present(alertController, animated: true)
        }
        else{
            alertController.addAction(UIAlertAction(title: "Remove Photo", style: .destructive, handler: { (action) in
                self.delegate?.didSelect(image: nil, button:101)
                
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                alertController.popoverPresentationController?.sourceView = sourceView
                alertController.popoverPresentationController?.sourceRect = sourceView.bounds
                alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
            }
            self.presentationController?.present(alertController, animated: true)
        }
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelect(image: image, button:controller.view.tag)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as! UIImage
        self.pickerController(picker, didSelect: chosenImage)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}
