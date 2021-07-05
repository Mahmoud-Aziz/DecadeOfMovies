//
//  MasterViewController.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 31/05/2021.
//

import UIKit

protocol MasterViewProtocol: AnyObject, NavigationRoute {
    func reloadMoviesTableView()
}

class MasterViewController: UIViewController {
    
    @IBOutlet private weak var moviesTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    var presenter: MasterPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MasterPresenter(view: self)
        registerTableViewCell()
        searchControllerParameters()
        presenter?.fetchMovies()
    }
    
     override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func registerTableViewCell() {
        let cellNib = UINib(nibName: "MoviesTableViewCell", bundle: nil)
        moviesTableView.register(cellNib, forCellReuseIdentifier: "MoviesTableViewCell")
    }
}

//MARK:- View Protocol Conformance

extension MasterViewController: MasterViewProtocol {
    func reloadMoviesTableView() {
        moviesTableView.reloadData()
    }
}

//MARK:- TableView Datasource methods

extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return presenter!.numberOfFilteredMovies
        }
        return presenter?.numberOfMovies ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        
        let movie: Movies
        
        if isFiltering {
            movie = (presenter?.filteredMovies(at: indexPath.row))!
            
        } else {
            movie = (presenter?.movie(at: indexPath.row))!
        }
        
        presenter?.fetchPosters(movie: movie)
//        let url = (presenter?.posterURL()[indexPath.row])!
        
//        cell.configureMovieTableCell(movie: movie, url: url)
        cell.configureMovieTableCell(movie: movie)

        
        return cell
    }
    
    
    
    //MARK:- TableView Section Methods
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let arr = presenter?.movieSection()
        return arr?[section].description
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let arr = presenter?.movieSection()
        return arr!.count
    }
    
    
}

//MARK:- TableView Delegate methods

extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isFiltering {
            presenter?.selectFilteredMovie(at: indexPath.row)
        } else {
            presenter?.selectMovie(at: indexPath.row)
        }
        moviesTableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- SearchController Methods

extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        let searchBar = searchController.searchBar
        presenter?.filterContentForSearchText(searchBar.text!)
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
