//
//  RequestHelper.swift
//  Memeful
//
//  Created by Koushik Dutta on 14/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import Foundation

class RequestHelper{
    
    static func infoForKey(key: String) -> String? {
           return Bundle.main.infoDictionary?[key] as? String
    }
}

