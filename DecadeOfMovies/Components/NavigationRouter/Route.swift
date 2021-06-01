//
//  Route.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 30/05/2021.
//

import Foundation
import UIKit

protocol Route {
    var destination: UIViewController { get }
    var style: NaivgationStyle { get }
}

enum NaivgationStyle {
    case modal
    case push
}
