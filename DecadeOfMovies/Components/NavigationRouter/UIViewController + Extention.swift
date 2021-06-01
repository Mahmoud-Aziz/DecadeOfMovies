//
//  UIViewController + Extention.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 30/05/2021.
//

import Foundation
import UIKit

protocol NavigationRoute {
    func navigate(to route: Route)
}

extension UIViewController: NavigationRoute {
    func navigate(to route: Route) {
        switch route.style {
        case .modal:
            self.present(route.destination, animated: true, completion: nil)
        case .push:
            self.navigationController?.pushViewController(route.destination, animated: true)
        }
    }
}
