//
//  MostViralPostViewModel.swift
//  Memeful
//
//  Created by Koushik Dutta on 14/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import Foundation
class MostViralPostViewModel{
    
    let service = NetworkManager()
    var posts: Posts?
    func fetchData(for page : Int, onCompletion: @escaping () ->Void) {
        self.service.getPosts(for: page) { (result) in
            switch(result){
            case .success(let posts):
                onCompletion()
                if page == 0{
                    self.posts = posts
                }
                else{
                    self.posts?.data.append(contentsOf: posts.data)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var postData : [Datum] {
        get{
            return self.posts?.data ?? []
        }
    }
}
