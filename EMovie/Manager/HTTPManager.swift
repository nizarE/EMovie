//
//  HTTPManager.swift
//  EMovie
//
//  Created by Nizar Elhraiech on 15/1/2022.
//

import Foundation
import UIKit

class HTTPManager{
    
    enum DownloadError: Error {
        case emptyData
        case invalidImage
    }

    func downloadImage(forURL url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(DownloadError.emptyData))
                return
            }
            completion(.success(data))
        }
        
        task.resume()
    }
}
