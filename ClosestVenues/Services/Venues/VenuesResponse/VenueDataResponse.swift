//
//  VenueDataResponse.swift
//  ClosestVenues
//
//  Created by Amosiejko on 19/04/2022.
//

import Foundation

struct VenueDataResponse : Decodable{
    var data : [Venue]
    
    private enum CodingKeys : String, CodingKey{
        case data = "results"
    }
}
