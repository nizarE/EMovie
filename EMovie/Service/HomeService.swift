//
//  HomeService.swift
//  EMovie
//
//  Created by Nizar Elhraiech on 15/1/2022.
//

import Foundation
import Combine
import Alamofire

class HomeService {
    
    @available(iOS 13.0, *)
    func login(urlDetail: URL, email: String , password: String) -> AnyPublisher<User, Error> {
        var request = URLRequest(url: urlDetail)
        let params = ["email" : email, "password" : password]
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(params)
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .mapError { $0 as Error }
            .decode(type: User.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func loginV2(urlDetail: URL, email: String , password: String){
        // prepare json data
        let params: [String: Any] = ["email": "testtech@easy.movie","password" : "@4YeQwqv6dYY"]

        let jsonData = try? JSONSerialization.data(withJSONObject: params)

        // create post request
        let url = URL(string: "https://dev-api.easy.movie/v1/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()

    }
    public func loginV3(urlDetail: URL, email: String , password: String){
        let parameters: Parameters = [ "email" : "testtech@easy.movie", "password" : "@4YeQwqv6dYY" ]

        let urlString = Constants.login_URL
        let url = URL.init(string: urlString)
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]

        AF.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            guard let data = response.data else {
                return
            }

             switch response.result
            {

            case .success(let json):
                 let decode = JSONDecoder()

                 let datas = try! decode.decode(User.self, from: data)
                 
                 print(datas)

             case .failure(let error): break
            }
        }


    }

    
    
}
