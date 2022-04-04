 //
//  DetailMovieViewController.swift
//  MobilPelis
//
//  Created by Sebastian Soto Varas on 4/04/22.
//

import UIKit

class DetailMovieViewController: UIViewController {

    var movie: MovieModel?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDetail()
    }
    
    private func setupDetail() {
        guard let obj = movie else {
            return
        }

        posterImageView.kf.setImage(with: URL(string: Endpoint.ImageBaseURL + "/\(obj.poster_path ?? "")"))
        titleLabel.text = movie?.title
        ratingLabel.text = String(movie?.vote_average ?? 0.0)
        launchDateLabel.text = movie?.release_date
        overviewLabel.text = movie?.overview
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
