//
//  OMDB_API.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 08/06/2021.
//

import Foundation
import Alamofire

class OMDB_Request {
     var movieTitle: String = ""
    
    func retrieveMoviePoster(_ completionHandler: @escaping (Result<OMDB, AFError>) -> Void
    ) {
        let url = "http://www.omdbapi.com/?t=\(movieTitle)&apikey=2351811f"
        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded) {
        AF.request(url).responseDecodable(completionHandler: { (response: DataResponse<OMDB, AFError>) in
            switch response.result {
            case .success(let poster):
                completionHandler(.success(poster))
            case .failure(let error):
                print(error)
            }
            
        })
    }
    }
}
