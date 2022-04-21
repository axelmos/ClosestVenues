//
//  VenueViewModel.swift
//  ClosestVenues
//
//  Created by Amosiejko on 19/04/2022.
//

import Foundation

class VenueViewModel {
    var _venues: [Venue]?
    var service: VenuesService
    
    init(service: VenuesService = VenuesService()) {
        self.service = service
    }
}

extension VenueViewModel: VenueProtocol {
    var venues: [Venue] {
        return _venues ?? []
    }
    
    func getClosestVenues(limit: Int, lat: String, long: String, completion: @escaping () -> (), failure: @escaping (String) -> ()) {
        service.getVenues(limit: limit, lat: lat, long: long) { [weak self] data in
            self?._venues = data
            completion()
        } failure: { error in
            failure(error)
        }
    }
}
