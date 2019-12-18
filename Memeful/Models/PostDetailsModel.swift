//
//  PostDetailsModel.swift
//  Memeful
//
//  Created by Koushik Dutta on 16/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit
// MARK: - ImageComments
struct ImageComments: Codable {
    let data: [CommentDetails]
    let success: Bool
    let status: Int
}

// MARK: - Datum
struct CommentDetails: Codable {
    let id: Int
    let imageID: String
    let comment: String
    let author: String
    let ups, downs, points, datetime: Int
    let children: [CommentDetails]

    enum CodingKeys: String, CodingKey {
        case id
        case imageID = "image_id"
        case comment, author
        case ups, downs, points, datetime
        case children
    }
}

