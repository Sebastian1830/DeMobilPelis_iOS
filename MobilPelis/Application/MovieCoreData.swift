//
//  MovieCoreData.swift
//  MobilPelis
//
//  Created by Sebastian Soto Varas on 4/04/22.
//

import CoreData

@objc(Movie)
class Movie: NSManagedObject {
    @NSManaged var poster_path: String!
    @NSManaged var overview: String!
    @NSManaged var release_date: String!
    @NSManaged var id: NSNumber!
    @NSManaged var original_language: String!
    @NSManaged var title: String!
    @NSManaged var vote_average: NSNumber!
}
