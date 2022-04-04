//
//  ListMovieViewModel.swift
//  MobilPelis
//
//  Created by Sebastian Soto Varas on 3/04/22.
//

import Foundation
import NotificationBannerSwift

class ListMovieViewModel: NSObject {
    
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
                self.movies = movies
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
}
