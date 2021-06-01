//
//  DetailsViewController.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 31/05/2021.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var genresLabel:UILabel!
    @IBOutlet private weak var castLabel:UILabel!
    @IBOutlet private weak var flickrCollectionView: UICollectionView!
    
    var movie: Movies?
    var photo: [Photo]?
    let request = FlickrRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        request.retrieveAllPhotos({ result in
            switch result {
            case .success(let flickr):
                let photosCollection = flickr.photos.photo
                self.photo = photosCollection
//                print("success")
            case .failure(let error):
                print(error)
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        movieTitleLabel.text = movie?.title
        if let rating = movie?.rating {
            ratingLabel.text = "\(String(describing: rating))"
        } else {
            return
        }
      
        let genresArray = movie?.genres
        let genresString = genresArray?.joined(separator: " - ")
        genresLabel.text = genresString
        
        let castArray = movie?.cast
        let castString = castArray?.joined(separator: " - ")
        castLabel.text = castString
    }
    
    private func registerCell() {
        let cellNib = UINib(nibName: "FlickrCollectionViewCell", bundle: nil)
        flickrCollectionView.register(cellNib, forCellWithReuseIdentifier: "FlickrCollectionViewCell")
    }
    
//    private func constructURL(server:String, id: String, secret: String, photo: Photo?) -> URL {
//                let urlScheme = "https://live.staticflickr.com/\(photo?.server)/\(photo?.id)_\(photo?.secret).jpg"
//                let url = URL(string: urlScheme)!
//        return url
//    }
}

//MARK:- CollectionView Datasource Methods

extension DetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = flickrCollectionView.dequeueReusableCell(withReuseIdentifier: "FlickrCollectionViewCell", for: indexPath) as! FlickrCollectionViewCell
        return cell
    }
        
    
}

//MARK:- CollectionView Delegate Methods

extension DetailsViewController: UICollectionViewDelegate {
    
}
