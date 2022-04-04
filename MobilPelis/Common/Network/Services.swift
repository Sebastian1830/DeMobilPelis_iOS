//
//  Services.swift
//  MobilPelis
//
//  Created by Sebastian Soto Varas on 2/04/22.
//

import Foundation
import Simple_Networking

class Services {
    
    private let apiKey = "f46b58478f489737ad5a4651a4b25079"
    
    func getMovies(page: Int, completion: @escaping(SNResultWithEntity<MovieModelResponse, MovieModelError>) -> ()) {
        
        let api = Endpoint.MoviesAPI + "?page=\(page)&api_key=\(apiKey)"
        
        SN.get(endpoint: api) {(response: SNResultWithEntity<MovieModelResponse, MovieModelError>) in
            completion(response)
        }
    }
}
