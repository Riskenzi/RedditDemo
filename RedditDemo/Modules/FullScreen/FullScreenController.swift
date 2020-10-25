//
//  FullScreenController.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 26.10.2020.
//

import UIKit

class FullScreenController: GlobalController {

    @IBOutlet weak var imageScreen: LoadingImageView!
    

    
    lazy var dataSource : FullScreenDataSource = {
        return FullScreenDataSource.init(self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepareViews() {
        super.prepareViews()
        dataSource.show()
    }
    
    override func setupAppearances() {
        super.setupAppearances()
        registerGesture()
    }
    
    private func registerGesture() -> Void {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        imageScreen.addGestureRecognizer(tap)
        imageScreen.isUserInteractionEnabled = true
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer? = nil) {
        MethodHelp.showAlertWithActions("System message", "Need save photo?") { ifNeed in
            if ifNeed {
                self.dataSource.saveImage()
            }
        }
    }
    
    
  
    
}
