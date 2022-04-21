//
//  Venue.swift
//  ClosestVenues
//
//  Created by Amosiejko on 19/04/2022.
//

import Foundation

struct Venue: Decodable {
    var name : String
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
}
