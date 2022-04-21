//
//  VenuesService.swift
//  ClosestVenues
//
//  Created by Amosiejko on 19/04/2022.
//

import Foundation

final class VenuesService : ApiService {
    func getVenues(limit: Int, lat: String, long: String, completion: @escaping ([Venue]) -> Void, failure: @escaping (String) -> Void) {
        
        let params = VenueApiParameters(limit: limit, latitude: lat, longitude: long)
        let apiParameters = ApiRequestParameters(parameters: params)
        let request = ApiRequest(path: .closestFiveVenues, method: .get, parameters:apiParameters)
        
        self.request(request, completion: { (response: VenueDataResponse) in
            completion(response.data)
        }, failure: { error in
            failure(error.message)
        })
    }
}
