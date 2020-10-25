//
//  NetworkManager.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 24.10.2020.
//

import Foundation
class NetworkManager {
    
    public let baseUrl = "https://www.reddit.com/"
    //https://www.reddit.com/top.json?limit=29
    
    enum APIRequest: String {
        case top = "top"
    }
    
    enum APIRequestType : String {
        case json = ".json"
    }

    static var shared: NetworkManager = { return NetworkManager() }()
    private init(){}

    public func getPage(_ pages: APIRequest ,_ after : String? = nil,completion: @escaping (Model?) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(pages.rawValue)\(APIRequestType.json.rawValue)?after=\(after ?? "")") else { fatalError("Invalid URL") }
        URLSession.shared.dataTask(with: url) { data, response, err in
            if(err != nil) {
                completion(nil)
            }
            guard let httpResponse = response as? HTTPURLResponse else { fatalError("URL Response Error") }
            switch httpResponse.statusCode {
            case 200:
                if let data = data {
                    do {
                    let data = try JSONDecoder().decode(Model.self, from: data)
                    completion(data)
                    } catch {
                        print("ERROR DECODING JSON \(err.debugDescription)")
                    }
                }
                break
            default:
                completion(nil)
                break
            }
        }.resume()
    }
    
    /// Result enum is a generic for any type of value
    /// with success and failure case
    public enum Result<T> {
        case success(T)
        case failure(Error)
    }

    
    // MARK: - Private functions
    private static func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Public function
    
    /// downloadImage function will download the thumbnail images
    /// returns Result<Data> as completion handler
    public static func downloadImage(url: URL,
                                     completion: @escaping (Result<Data>) -> Void) {
        NetworkManager.getData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
    
}
