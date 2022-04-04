//
//  ListMovieViewModel.swift
//  MobilPelis
//
//  Created by Sebastian Soto Varas on 3/04/22.
//

import Foundation
import NotificationBannerSwift
import CoreData
import Network

class ListMovieViewModel: NSObject {
    
    private let monitor = NWPathMonitor()
    private var services: Services?
    private var movies = MovieModelResponse() {
        didSet {
            self.bindPostViewModelToController()
        }
    }
    
    public var bindPostViewModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        self.services = Services()
    }
    
    init(page: Int) {
        super.init()
        self.services = Services()
        self.getMovies(page: page)
    }
    
    private func getMovies(page: Int) {
        Services().getMovies(page: page) {
            switch $0 {
            case .success(let movies):
                var dataPersistence = MovieModelResponse()
                if !self.verifiedConnection() {
                    dataPersistence.results = self.getMovieDataPersistence()
                    dataPersistence.total_results = self.getMovieDataPersistence().count
                }
                self.movies = self.verifiedConnection() ? movies : dataPersistence
                if self.verifiedConnection() { self.saveDataPersistence(movies: movies) }
            case .error(let error):
                NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: BannerStyle.danger).show()
            case .errorResult(let entity):
                NotificationBanner(title: "Error", subtitle: entity.status_message, style: BannerStyle.warning).show()
            }
        }
    }
    
    func getPosts() -> MovieModelResponse? {
        return movies
    }
    
    private func saveDataPersistence(movies: MovieModelResponse) {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)
            
            for item in movies.results {
                if !self.existMovie(id: item.id) {
                    let newMovie = Movie(entity: entity!, insertInto: context)
                    newMovie.id = NSNumber(value: item.id)
                    newMovie.overview = item.overview
                    newMovie.release_date = item.release_date
                    newMovie.vote_average = NSNumber(value: item.vote_average)
                    newMovie.poster_path = item.poster_path
                    newMovie.original_language = item.original_language
                    newMovie.title = item.title
                }
            }
            
            do {
                try context.save()
            } catch {
                print("context save error")
            }
        }
    }
    
    private func getMovieDataPersistence() -> [MovieModel] {
        var movies = [MovieModel]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let moviePersistence = result as! Movie
                var movie = MovieModel()
                movie.id = Int(truncating: moviePersistence.id)
                movie.overview = moviePersistence.overview
                movie.release_date = moviePersistence.release_date
                movie.vote_average = Double(truncating: moviePersistence.vote_average)
                movie.poster_path = moviePersistence.poster_path
                movie.original_language = moviePersistence.original_language
                movie.title = moviePersistence.title
                movies.append(movie)
            }
        } catch {
            print("Fetch Failed")
        }
        return movies
    }
    
    private func existMovie(id: Int) -> Bool {
        for movie in getMovieDataPersistence() {
            if movie.id == id { return true }
        }
        return false
    }
    
    private func verifiedConnection() -> Bool {
        var connection = true
        monitor.pathUpdateHandler = {path in
            if path.status == .satisfied {
                connection = true
            } else {
                connection = false
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        return connection
    }
}
