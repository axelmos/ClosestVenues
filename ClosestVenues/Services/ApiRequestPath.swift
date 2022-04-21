//
//  ApiRequestPath.swift
//  ClosestVenues
//
//  Created by Amosiejko on 19/04/2022.
//

import Foundation

enum Enviroment {
   case dev
   case prod
}
 
var enviroment: Enviroment = .prod

enum ApiRequestPath {
    case closestFiveVenues
    
    var subPath: String {
        switch self {
        case .closestFiveVenues: return "places/nearby"
        }
    }
    
    var basePath: String {
        if enviroment == .dev { return "https://api.foursquare.com/v3/" }
        
        switch self {
        case .closestFiveVenues: return "https://api.foursquare.com/v3/"
        }
    }
}
