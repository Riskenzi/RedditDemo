//
//  Models.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 25.10.2020.
//

import Foundation
struct Model : Decodable {
    let kind: String?
    let data: ModelData?
}

// MARK: - ModelData
struct ModelData : Decodable {
    let modhash: String?
    let dist: Int?
    let children: [Child]?
    let after: String?
}

// MARK: - Child
struct Child : Decodable {
    let kind: String?
    let data: ChildData?
}

// MARK: - ChildData
struct ChildData : Decodable {
    let subreddit,authorFullname, title: String?
    let thumbnailHeight: Int?
    let name: String?
    let thumbnailWidth: Int?
    let thumbnail: String?
    let created: Int?
    let preview: Preview?
    let subredditID, id, author: String?
    let num_comments: Int?
    let permalink, parentWhitelistStatus: String?
    let url: String?
}

// MARK: - Preview
struct Preview : Decodable {
    let images: [Image]?
    let enabled: Bool?
}

// MARK: - Image
struct Image : Decodable {
    let source: Source?
    let resolutions: [Source]?
    let id: String?
}

// MARK: - Source
struct Source : Decodable {
    let url: String?
    let width, height: Int?
}
