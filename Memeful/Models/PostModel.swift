//
//  PostModel.swift
//  Memeful
//
//  Created by Koushik Dutta on 14/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit
struct Posts: Codable {
    var data: [Datum]
    let success: Bool
    let status: Int
}

struct Datum: Codable {
    let id: String?
    let title: String?
    let datumDescription: String?
    let link: String?
    let ups, downs: Int?
    let images: [Image]?
    var imageUrl: URL? {
            guard let urlString = images?.first?.link else {return nil}
            return URL(string: urlString)
    }
    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
        case link
        case ups, downs
        case images
    }
}

struct Image: Codable {
    let link: String?
    let height: Int?
    let width: Int?
    var aspectRatio : Float{
        get{
            if let height = height, let width = width{
                return Float(height) / Float(width)
            }
            return 1
        }
    }
}

enum TypeEnum: String, Codable {
    case imageGIF = "image/gif"
    case imageJPEG = "image/jpeg"
    case imagePNG = "image/png"
    case videoMp4 = "video/mp4"
}

