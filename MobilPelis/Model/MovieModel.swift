//
//  MovieModel.swift
//  MobilPelis
//
//  Created by Sebastian Soto Varas on 2/04/22.
//

import Foundation

struct MovieModel: Codable {
    var poster_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var id: Int
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var vote_average: Double
}

struct Dates: Codable {
    var maximum: String = ""
    var minimum: String = ""
}

struct MovieModelResponse: Codable {
    var page: Int = 1
    var results: [MovieModel] = [MovieModel]()
    var dates: Dates = Dates()
    var total_pages: Int = 1
    var total_results: Int = 1
}

struct MovieModelError: Codable {
    var status_message: String
    var status_code: Int
}
