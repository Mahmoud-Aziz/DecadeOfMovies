//
//  MasterPresenter.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 01/06/2021.
//

import Foundation
import ProgressHUD

protocol MasterPresenterProtocol {
    var numberOfMovies: Int { get }
    var numberOfFilteredMovies: Int { get }
    func fetchMovies()
    func posterURL() -> [String]
    func fetchPosters(movie: Movies)
    func movie(at index: Int) -> Movies
    func filteredMovies(at index: Int) -> Movies
    func selectMovie(at index: Int)
    func selectFilteredMovie(at index: Int)
    func filterContentForSearchText(_ searchText: String)
    func movieSection() -> [Int]?
}


class MasterPresenter {
    private var movies: [Movies] = []
    var poster: [String] = []
    var filteredMovies: [Movies] = []
    weak var view: MasterViewProtocol?
    var photosCollection: [Photo]?
    var date : [Int]? = []
    
    init(view: MasterViewProtocol?) {
        self.view = view
    }
}

extension MasterPresenter: MasterPresenterProtocol {
    
    func movie(at index: Int) -> Movies {
        movies[index]
    }
    func filteredMovies(at index: Int) -> Movies {
        filteredMovies[index]
    }
    
    
    var numberOfMovies: Int {
        movies.count
    }
    
    var numberOfFilteredMovies: Int {
        filteredMovies.count
    }
    
    func fetchMovies() {
        
        let movies =  Bundle.main.decode(MoviesJSON.self, from: "movies.json")
        let moviesCollection = movies.movies.sorted(by: { $0.year! > $1.year! })
        self.movies = moviesCollection
        for movie in moviesCollection {
            self.date?.append(movie.year ?? 0)
        }
    }
    
    func movieSection() -> [Int]? {
        return self.date?.unique()
    }
    
    
    func fetchPosters(movie: Movies) {
        ProgressHUD.show()
        let request = OMDB_Request()
        request.movieTitle = movie.title
        request.retrieveMoviePoster({ [weak self] result in
            switch result {
            case .success(let posters):
                ProgressHUD.dismiss()
                self?.poster.append(posters.Poster)
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
                print(error)
            }
        })
    }
    
    func posterURL() -> [String] {
        return poster
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMovies = movies.filter{ (movie:Movies) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        
        view?.reloadMoviesTableView()
        
    }
    
    func selectMovie(at index: Int) {
        
        let selectedMovie = movies[index]
        let detailsControllerRoute = MasterRoutes.movieDetails(selectedMovie)
        view?.navigate(to: detailsControllerRoute)
    }
    
    func selectFilteredMovie(at index: Int) {
        
        let selectedMovie = filteredMovies[index]
        let detailsControllerRoute = MasterRoutes.movieDetails(selectedMovie)
        view?.navigate(to: detailsControllerRoute)
    }
    
    
}
