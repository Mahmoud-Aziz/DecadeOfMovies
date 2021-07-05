//
//  DetailsPresenter.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 02/06/2021.


import Foundation
import ProgressHUD

protocol DetailsPresenterProtocol {
    var moviePoster: URL? { get }
    var photosCount: [Photo]? { get }
    func fetchPhotos()
    func fetchPoster()
    func moviePosterURL() -> URL?
    func movieTitle() -> String
    func movieYear() -> Int?
    func movieGenres() -> [String]
    func movieRating() -> Int
    func movieCast() -> [String]
    func constructURL(for index: Int) -> URL
}

class DetailsPresenter: DetailsPresenterProtocol {
    var photosCount: [Photo]?
    weak var view: DetailsViewProtocol?
    private var movie: Movies
    private var photos: [Photo]?
    private var moviePosterUrlString = ""
    private var url: URL?
    var moviePoster: URL?
    
    init(view: DetailsViewProtocol?, movie: Movies) {
        self.movie = movie
        self.view = view
    }
    
    func movieTitle() -> String {
        movie.title
    }
    
    func movieYear() -> Int? {
        movie.year
    }
    
    func movieGenres() -> [String] {
        movie.genres
    }
    
    func movieRating() -> Int {
        movie.rating
    }
    
    func movieCast() -> [String] {
        movie.cast
    }
    
    func moviePosterURL() -> URL? {
        self.moviePoster
    }
    
    func fetchPhotos() {
        ProgressHUD.show()
        let request = FlickrRequest()
        FlickrRouter.searchQuery = "\(movieTitle())"
        request.retrieveAllPhotos({ [weak self] result in
            switch result {
            case .success(let flickr):
                ProgressHUD.dismiss()
                let photosCollection = flickr.photos.photo
                print(photosCollection)
                self?.photos = photosCollection
                self?.photosCount = photosCollection
                self?.view?.reloadCollectionView()
                print("success")
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchPoster() {
        let request = OMDB_Request()
        request.movieTitle = "\(movieTitle())"
        request.retrieveMoviePoster({ [weak self] result in
            switch result {
            case .success(let poster):
                ProgressHUD.dismiss()
                self?.moviePosterUrlString = poster.Poster
                self?.moviePoster = URL(string: poster.Poster)
                print("poster fetched")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
                print(error)
            }
        })
    }
    
    func constructURL(for index: Int) -> URL {
        guard self.photos?.count != 0 else {
            let url = URL(string: "https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg")!
            return url
        }
        let photoIndex = self.photos?[index]
        let urlScheme = "https://live.staticflickr.com/\(photoIndex?.server ?? "")/\(photoIndex?.id ?? "")_\(photoIndex?.secret ?? "").jpg"
        let url = URL(string: urlScheme)
        return url ?? URL(string: "error")!
    }
}



