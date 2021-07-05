//
//  DetailsViewController.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 31/05/2021.
//

import UIKit
import Kingfisher
import ProgressHUD

protocol DetailsViewProtocol: AnyObject {
    func reloadCollectionView()
}

class DetailsViewController: UIViewController {

    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var genresLabel:UILabel!
    @IBOutlet private weak var castLabel:UILabel!
    @IBOutlet private weak var flickrCollectionView: UICollectionView!
    @IBOutlet private weak var moviePosterImageView: UIImageView!
    
    
    var presenter: DetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        ProgressHUD.show()
        presenter?.fetchPhotos()
        presenter?.fetchPoster()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        movieTitleLabel.text = presenter?.movieTitle()
        
        if let rating = presenter?.movieRating() {
            ratingLabel.text = "\(String(describing: rating))"
        } else {
            return
        }
        
        let genresArray = presenter?.movieGenres()
        let genresString = genresArray?.joined(separator: " - ")
        genresLabel.text = genresString
        
        let castArray = presenter?.movieCast()
        let castString = castArray?.joined(separator: " - ")
        castLabel.text = castString
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let url = self.presenter?.moviePosterURL()
            self.moviePosterImageView.kf.setImage(with: url)
        })
        
    }
    
    private func registerCell() {
        let cellNib = UINib(nibName: "FlickrCollectionViewCell", bundle: nil)
        flickrCollectionView.register(cellNib, forCellWithReuseIdentifier: "FlickrCollectionViewCell")
    }

}

extension DetailsViewController: DetailsViewProtocol {
    func reloadCollectionView() {
        flickrCollectionView.reloadData()
    }

}

//MARK:- CollectionView Datasource Methods

extension DetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.photosCount?.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = flickrCollectionView.dequeueReusableCell(withReuseIdentifier: "FlickrCollectionViewCell", for: indexPath) as! FlickrCollectionViewCell
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            let url = self.presenter?.constructURL(for: indexPath.row)
            cell.configure(url: url)

        })
        return cell
    }
}

//MARK:- CollectionView Delegate Methods

extension DetailsViewController: UICollectionViewDelegate {
    
}
