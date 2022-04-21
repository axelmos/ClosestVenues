//
//  VenueApiParameters.swift
//  ClosestVenues
//
//  Created by Amosiejko on 20/04/2022.
//

import Foundation

struct VenueApiParameters: ApiParametersProtocol {
    
    var limit: Int
    var latitude: String
    var longitude: String
     
    init(limit: Int, latitude: String, longitude: String) {
        self.limit = limit
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func queryParams() -> ApiParameters {
        return ["limit": limit, "ll": "\(latitude),\(longitude)"]
    }
}
    
    
    

