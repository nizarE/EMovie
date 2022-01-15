//
//  HomeViewModel.swift
//  EMovie
//
//  Created by Nizar Elhraiech on 15/1/2022.
//

import Foundation
import Combine

@available(iOS 13.0, *)
class HomeViewModel {
    
    // MARK: Variable
    var errorFromServer = CurrentValueSubject<Bool,Never>(false)
    var connexion = CurrentValueSubject<Bool,Never>(false)
    var user = PassthroughSubject<User,Never>()
    var email = CurrentValueSubject<String,Never>("")
    var password = CurrentValueSubject<String,Never>("")

    private let httpManager = HTTPManager()
    private let homeService = HomeService()
    var bag = Set<AnyCancellable>()
    
    func login() {
//        if Reachability.isConnectedToNetwork(){
//            guard let url = encodeUrl(title: Constants.login_URL) else {
//                return
//            }
//            homeService.login(urlDetail: url,email:  email.value,password: password.value).sink(receiveCompletion: {
//                completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }, receiveValue: {
//                response in
//                self.user.send(response)
//
//            }).store(in: &bag)
//        } else {
//            connexion.send(true)
//        }
        guard let url = encodeUrl(title: Constants.login_URL) else {
                return
        }
        homeService.loginV3(urlDetail: url,email:  email.value,password: password.value)
    }
    
    func VideoVM(subtitle: String, titleT : String, urlPrg : String) {
    }
    
    func loadImage(imageUrl : String , completionHandler: @escaping (Data?) -> Void){
        guard let url = URL(string: imageUrl) else { return }
        httpManager.downloadImage(forURL: url, completion: {
            result in
            guard let data = try? result.get() else {
                return
            }
            completionHandler(data)
        })
    }
    
    func encodeUrl(title : String) -> URL? {
        let fullUrl = Constants.login_URL
        return URL(string: fullUrl)
    }
}
