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

    override func awakeFromNib() { super.awakeFromNib() }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePosterImageView.image = nil
    }
    
//    func configureMovieTableCell(movie: Movies?, url: String) {
//        moviePosterImageView.kf.setImage(with: URL(string: url))
//        movieTitleLabel.text = movie?.title
//        movieYearLabel.text = "\(movie?.year ?? 0)"
//
//        let genresArray = movie?.genres
//        let genresString = genresArray?.joined(separator: " - ")
//        movieGenresLabel.text = genresString
//    }
    
    func configureMovieTableCell(movie: Movies?) {
        movieTitleLabel.text = movie?.title
        movieYearLabel.text = "\(movie?.year ?? 0)"
        
        let genresArray = movie?.genres
        let genresString = genresArray?.joined(separator: " - ")
        movieGenresLabel.text = genresString
    }
}
