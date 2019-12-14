//
//  NetworkManager.swift
//  Memeful
//
//  Created by Koushik Dutta on 14/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import Foundation

class NetworkManager
{
    func getPosts(for page: Int, completion: ((Result<Posts, Error>) -> Void)?)
    {
        var urlComponents = URLComponents()
        urlComponents.scheme = RequestHelper.infoForKey(key: "Api Protocol")!
        urlComponents.host = RequestHelper.infoForKey(key: "Api Base Url")!
        urlComponents.path = "/\(RequestHelper.infoForKey(key: "Api Version")!)/gallery/top/viral/day/\(page)"
        let showViral = URLQueryItem(name: "showViral", value: "true")
        let mature = URLQueryItem(name: "mature", value: "true")
        let albumPreviews = URLQueryItem(name: "album_previews", value: "true")
        urlComponents.queryItems = [showViral, mature, albumPreviews]
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(RequestHelper.infoForKey(key: "Client Id")!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                do {
                    let posts = try JSONDecoder().decode(Posts.self, from: jsonData)
                    completion?(.success(posts))
                } catch {
                    completion?(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                completion?(.failure(error))
            }
        }
        task.resume()
    }
}
