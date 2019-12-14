//
//  PostModel.swift
//  Memeful
//
//  Created by Koushik Dutta on 14/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit
struct Posts: Codable {
    let data: [Datum]
    let success: Bool
    let status: Int
}

struct Datum: Codable {
    let id: String?
    let title: String?
    let datumDescription: String?
//    let datetime: Int?
//    let type: TypeEnum?
//    let favorite: Bool?
//    let inMostViral: Bool?
//    let inGallery: Bool?
    let link: String?
    //let commentCount, favoriteCount,
    let ups, downs: Int?

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
//        case datetime, type, favorite
//        case inMostViral = "in_most_viral"
//        case inGallery = "in_gallery"
        case link
//        case commentCount = "comment_count"
//        case favoriteCount = "favorite_count"
        case ups, downs
    }
}

enum TypeEnum: String, Codable {
    case imageGIF = "image/gif"
    case imageJPEG = "image/jpeg"
    case imagePNG = "image/png"
    case videoMp4 = "video/mp4"
}

