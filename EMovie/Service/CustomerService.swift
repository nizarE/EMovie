//
//  CustomerService.swift
//  EMovie
//
//  Created by Nizar Elhraiech on 15/1/2022.
//

import Foundation
import Foundation
import Combine

class CustomerService {
    @available(iOS 13.0, *)
    func getCustomer(urlDetail: URL, start: Int , limit: Int,orderBy: String, orderDir: String, token: String) -> AnyPublisher<Customer, Error> {
        let BearerAuthHeader = "Bearer \(token)"
        var request = URLRequest(url: urlDetail)
        let params = ["start" : start,
                      "limit" : limit,
                      "orderBy" : orderBy,
                      "orderDir" : orderDir,
                      "token" : token] as [String : Any]
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(BearerAuthHeader, forHTTPHeaderField: "Authorization")
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        request.httpBody = jsonData
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .mapError { $0 as Error }
            .decode(type: Customer.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
