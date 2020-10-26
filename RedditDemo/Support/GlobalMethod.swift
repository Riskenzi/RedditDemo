//
//  GlobalMethod.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 26.10.2020.
//

import UIKit

class MethodHelp: NSObject {
    
    static func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    static func correctingImageURL(urlString: String) -> String {
        var imageUrl = urlString.replacingOccurrences(of: "amp;", with: "", options: NSString.CompareOptions.literal, range: nil)
        imageUrl = imageUrl.replacingOccurrences(of: "amp;s", with: "s", options: NSString.CompareOptions.literal, range: nil)
        return imageUrl
    }
    static func showAlertSingle(_ title: String, _ message: String? = nil) -> Void {
        
        guard let rootVC = Navigation.getRootViewController(),
            let visableController = Navigation.getVisibleViewController(rootVC) else {
                print("🤷🏼‍♀️ Root ViewController or VisableController didn't found.")
                return
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        visableController.present(ac, animated: true, completion: nil)
    }
    
    static func showAlertWithActions(_ title: String, _ message: String,buttonSave: @escaping (_ action: Bool) -> Void) {
        
        guard let rootVC = Navigation.getRootViewController(),
              let visableController = Navigation.getVisibleViewController(rootVC) else {
            print("🤷🏼‍♀️ Root ViewController or VisableController didn't found.")
            return
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            buttonSave(true)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        visableController.present(ac, animated: true, completion: nil)
    }
    
}
