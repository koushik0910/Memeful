//
//  PostDetailsViewModel.swift
//  Memeful
//
//  Created by Koushik Dutta on 16/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import Foundation

class PostDetailsViewModel {
    let service = NetworkManager()
    var comments : ImageComments?
    
    func fetchComments( for galleryId : String, onCompletion: @escaping () ->Void) {
        self.service.getBestComments(for: galleryId) { (result) in
            switch(result){
            case .success(let comments):
                onCompletion()
                self.comments = comments
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var commentsData : [CommentDetails] {
        get{
            return self.comments?.data ?? []
        }
    }
    
    
}
