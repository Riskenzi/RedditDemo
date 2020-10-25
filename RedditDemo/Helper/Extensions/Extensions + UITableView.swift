//
//  UITableView+Extensions.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 25.10.2020.
//

import UIKit

extension UITableView {
    func registerCellFromNib(_ nameCell: String) -> Void{
        let nib = UINib(nibName: nameCell, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nameCell)
    }
}

