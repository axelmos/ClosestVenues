//
//  VenueProtocol.swift
//  ClosestVenues
//
//  Created by Amosiejko on 19/04/2022.
//

import Foundation

protocol VenueProtocol {
    var venues: [Venue] { get }
    
    func getClosestVenues(limit: Int, lat: String, long: String, completion: @escaping () -> (), failure: @escaping (String) -> ())
}
