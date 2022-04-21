//
//  ApiError.swift
//  ClosestVenues
//
//  Created by Amosiejko on 19/04/2022.
//

import Foundation

struct ApiError: Error {
    var message:String
    var statusCode:String
    var details: [String]

}

extension ApiError: Decodable {
    private enum CodingKeys: String, CodingKey {
        case message = "message"
        case statusCode = "code"
        case details = "details"
    }
}
