//
//  ApiParameterEncoding.swift
//  ClosestVenues
//
//  Created by Amosiejko on 19/04/2022.
//

import Foundation

enum ParamsEncoding {
    case json
}

struct ApiParameterEncoding {
    let parameterEncoding: ParamsEncoding
    
    init(parameterEncoding: ParamsEncoding) {
        self.parameterEncoding = parameterEncoding
    }
    
    func encodingType() -> String {
        return "application/json"
    }
}
