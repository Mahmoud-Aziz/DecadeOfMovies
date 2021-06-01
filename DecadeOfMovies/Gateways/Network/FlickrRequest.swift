//
//  FlickrRequest.swift
//  DecadeOfMovies
//
//  Created by Mahmoud Aziz on 30/05/2021.
//

import Foundation
import Alamofire

class FlickrRequest {
        
    func retrieveAllPhotos(
        _ completionHandler: @escaping (Result<Flickr, AFError>) -> Void
    ) {
        let route = FlickrRouter.allPhotos
        AF.request(route).responseDecodable { (response: DataResponse<Flickr, AFError>) in

            switch response.result {
            case .success(let photos):
                completionHandler(.success(photos))
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
    }
}
