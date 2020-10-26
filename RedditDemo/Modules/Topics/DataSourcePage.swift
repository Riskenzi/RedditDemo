//
//  DataSource.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 25.10.2020.
//

import Foundation
import UIKit

protocol DataSourcePageDelegate {
    func getTopicData(_ data : [Child]?)
}

class DataSourcePage : NSObject {
    // MARK: - Properties
   
    weak var controller: PageVC!
    
    private var viewModel = TopicViewModel()
    
    private var data = [Child]()
    
    private var refreshControl = UIRefreshControl()
    private let  spinner = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Life cycle
    
    init(_ controller: PageVC) {
        super.init()
        
        self.controller = controller
        self.setupTable()
        self.setupRefresh()
        
        viewModel.featchTopics()
    }
    
    private func setupTable() {
        
        viewModel.delegate = self
        controller.tableView?.registerCellFromNib(UINib.idenXibTopicCell)
        controller.tableView?.separatorStyle = .none
        controller.tableView?.delegate = self
        controller.tableView?.dataSource = self
        controller.tableView?.rowHeight = UITableView.automaticDimension
        controller.tableView?.estimatedRowHeight = 600

    }
    
    private func setupRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        controller.tableView?.addSubview(refreshControl)
        
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        controller.tableView?.tableFooterView = spinner
    }
    
    @objc func refresh(_ sender: AnyObject) {
      viewModel.featchTopics()
      refreshControl.endRefreshing()
    }
    
    private func reloadContainers() {
        DispatchQueue.main.async { [weak self] in
            
            self?.controller.tableView?.reloadData()
        }
    }
}

extension DataSourcePage : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = self.controller?.tableView?.dequeueReusableCell(withIdentifier:UINib.idenXibTopicCell , for: indexPath) as! TopicCell
        if let cellData = data[indexPath.row].data {
            
                cell.show(data: cellData)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cellData = data[indexPath.row].data {
            cellData.preview?.images?.forEach({ (image) in
                if let imageUrl = image.source?.url {
                    if MethodHelp.verifyUrl(urlString: imageUrl) {
                        let correctUrl = MethodHelp.correctingImageURL(urlString: imageUrl)
                        guard let navigation = self.controller.navigationController else { return }
                        Navigation.navigateFullScreen(in: navigation,correctUrl)
                    }
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = data.count - 1
        if indexPath.row == lastItem {
            guard let next = viewModel.nextPage else { return }
            spinner.startAnimating()
            viewModel.featchPagination(next)
        }
    }

}
extension DataSourcePage : DataSourcePageDelegate {
    func getTopicData(_ data: [Child]?) {
        guard let data = data else { return }
        self.data = data
        self.reloadContainers()
    }
}


