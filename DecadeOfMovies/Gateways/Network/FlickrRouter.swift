//
//  FlickrRouter.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 30/05/2021.
//

import Foundation
import Alamofire

enum FlickrRouter: URLRequestConvertible {

    static let baseURL = "https://api.flickr.com/services/rest/"
    static var searchQuery: String?
    case allPhotos

    var httpMethod: HTTPMethod {
        switch self {
        case .allPhotos:
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .allPhotos:
            return [
                "method": "flickr.photos.search",
                "api_key": "86997f23273f5a518b027e2c8c019b0f",
                "sort": "relevance",
                "per_page": "30",
                "format": "json",
                "nojsoncallback": "1",
                "extras": "url_q,url_z",
                "text": "\(FlickrRouter.searchQuery ?? "movies")"
                ]
        }
    }

    var headers: [String: String] {
        switch self {
        case .allPhotos:
            return [:]
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .allPhotos:
            return URLEncoding.default
        }
    }

    func asURLRequest() throws -> URLRequest {
        let urlString = FlickrRouter.baseURL
        let url = URL(string: urlString)!

        var request = URLRequest(url: url)
        request.method = self.httpMethod
        request.headers = HTTPHeaders(headers)

        return try! encoding.encode(request, with: parameters)
    }
    
    
}
