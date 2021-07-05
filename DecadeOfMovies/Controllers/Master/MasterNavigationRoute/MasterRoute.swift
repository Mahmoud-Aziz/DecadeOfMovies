//
//  MasterRoute.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 02/06/2021.
//

import Foundation
import UIKit

enum MasterRoutes: Route {
    case movieDetails(Movies)

    var destination: UIViewController {
        switch self {
        case .movieDetails(let movie):
           
            let MovieDetailsViewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)

            MovieDetailsViewController.presenter = DetailsPresenter(view: DetailsViewController(), movie: movie)
            return MovieDetailsViewController
        }
    }

    var style: NaivgationStyle {
        switch self {
        case .movieDetails:
            return .push
        }
    }
}
