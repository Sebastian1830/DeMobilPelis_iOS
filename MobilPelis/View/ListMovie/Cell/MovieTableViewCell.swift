//
//  MovieTableViewCell.swift
//  MobilPelis
//
//  Created by Sebastian Soto Varas on 3/04/22.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellWith(movie: MovieModel) {
        guard let poster = movie.poster_path else { return}
        if !poster.isEmpty { posterImageView.kf.setImage(with: URL(string: Endpoint.ImageBaseURL + "/\(poster)")) }
        titleLabel.text = movie.title
        launchDateLabel.text = movie.release_date
        languageLabel.text = movie.original_language
        ratingLabel.text = String(movie.vote_average)
    }
}
