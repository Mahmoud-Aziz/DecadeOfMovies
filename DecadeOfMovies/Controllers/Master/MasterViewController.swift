//
//  MasterViewController.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 31/05/2021.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet private weak var moviesTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var movies: [Movies] = []
    var filteredMovies: [Movies] = []
    let request = FlickrRequest()
    var photosCollection: [Photo]?
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        searchControllerParameters()
        self.movies = Movies.fetchMovies()
        
        request.retrieveAllPhotos({ result in
            switch result {
            case .success(let photo):
                let photos = photo.photos.photo
                self.photosCollection = photos
            case .failure(let error):
                print(error.errorDescription!)
            }
        })
    }

    
    private func registerTableViewCell() {
        let cellNib = UINib(nibName: "MoviesTableViewCell", bundle: nil)
        moviesTableView.register(cellNib, forCellReuseIdentifier: "MoviesTableViewCell")
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMovies = movies.filter{ (movie:Movies) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        moviesTableView.reloadData()
    }
}

//MARK:- TableView Datasource methods

extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMovies.count
        }
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            cell.constructPosterURL(photo: (self.photosCollection?[indexPath.row])!)
        })
        
        let movie: Movies
        if isFiltering {
            movie = filteredMovies[indexPath.row]
            
        } else {
            movie = movies[indexPath.row]
        }
        cell.configureMovieTableCell(movie: movie)
        return cell
    }
}

//MARK:- TableView Delegate methods

extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        if isFiltering {
            vc.movie = filteredMovies[indexPath.row]
        } else {
            vc.movie = movies[indexPath.row]
        }
        moviesTableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- SearchController Methods

extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    private func searchControllerParameters() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        searchController.searchBar.showsCancelButton = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

