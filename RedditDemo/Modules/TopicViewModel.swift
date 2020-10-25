//
//  TopicViewModel.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 25.10.2020.
//

import UIKit


protocol TopicViewModelDelegate {
    
    func featchTopics()
    
    func featchPagination(_ after : String)
}

class TopicViewModel : TopicViewModelDelegate {
    var data : [Child] = [Child]()
    var nextPage : String? = nil
    var delegate : DataSourcePageDelegate?
    
    func featchTopics() {
        NetworkManager.shared.getPage(NetworkManager.APIRequest.top) { [self] (model) in
            data = model?.data?.children ?? []
            nextPage = model?.data?.after ?? nil
            delegate?.getTopicData(data)
        }
    }
    
    func featchPagination(_ after: String) {
        NetworkManager.shared.getPage(NetworkManager.APIRequest.top, after) { [self] (model) in
            nextPage = model?.data?.after ?? nil
            model?.data?.children?.forEach({ (child) in
                data.append(child)
            })
            delegate?.getTopicData(data)
        }
    }
    
    
}
