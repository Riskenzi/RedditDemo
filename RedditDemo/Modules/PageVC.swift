//
//  PageVC.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 25.10.2020.
//

import UIKit

class PageVC: GlobalController {

    @IBOutlet weak var tableView: UITableView?
    
    lazy var delegate: DataSourcePage = {
        return .init(self)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Top topics"
        initTableView()
        // Do any additional setup after loading the view.
    }

    override func setupAppearances() {
        super.setupAppearances()
        tableView?.backgroundColor = .clear
    }
    
    override func setupObservers() {
        super.setupObservers()
    }
    
    func initTableView() -> Void {
        _ = self.delegate
    }
}
