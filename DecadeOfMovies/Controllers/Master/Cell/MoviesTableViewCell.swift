//
//  MoviesTableViewCell.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 31/05/2021.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieGenresLabel: UILabel!
    @IBOutlet private weak var moviePosterImageView: UIImageView!
    
    var posterURL: URL? {
        didSet {
            moviePosterImageView.kf.setImage(with: posterURL)
        }
    }

    override func awakeFromNib() { super.awakeFromNib() }
    
    func configureMovieTableCell(movie: Movies?) {
        
        movieTitleLabel.text = movie?.title
        movieYearLabel.text = "\(movie?.year ?? 0)"
        
        let genresArray = movie?.genres
        let genresString = genresArray?.joined(separator: " - ")
        movieGenresLabel.text = genresString
    }
    
    func constructPosterURL(photo:Photo) {
        let server = photo.server
        let id = photo.id
        let secret = photo.secret
        let urlScheme = "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
        let urlString = URL(string: urlScheme)
        self.posterURL = urlString
        print(urlString ?? "failed to get url")
    }
}
