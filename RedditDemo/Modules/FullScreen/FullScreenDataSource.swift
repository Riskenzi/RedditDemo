//
//  FullScreenDataSource.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 26.10.2020.
//

import UIKit

class FullScreenDataSource: NSObject {
    
    weak var controller: FullScreenController?
    
    public var imageURL : String? = nil
    
    init(_ controller: FullScreenController) {
        super.init()
        self.controller = controller
        
      }
    
    public func show() -> Void {
        guard let url = imageURL else { return }
        controller?.imageScreen.loadImage(from: url)
    }
    
    
    public  func saveImage() -> Void {
        guard let image =   controller?.imageScreen.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self,
            #selector(saving(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
   
    @objc func saving(_ image: UIImage,
                      didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            MethodHelp.showAlertSingle("Saved!", "Your image has been saved to your photos.")
        } else {
            MethodHelp.showAlertSingle("Save Error!", error?.localizedDescription)
        }
    }
    
    
    
}
