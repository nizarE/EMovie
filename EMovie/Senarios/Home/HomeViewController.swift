//
//  HomeViewController.swift
//  EMovie
//
//  Created by Nizar Elhraiech on 15/1/2022.
//

import UIKit
import Combine

@available(iOS 13.0, *)
class HomeViewController: UIViewController {
    
    // MARK: Outlets    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    // MARK: Variable
    var user : User?
    var viewModel = HomeViewModel()
    var bag = Set<AnyCancellable>()
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setViewModel(viewModel)
        bindViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    private func setViewModel(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    private func bindViewModel() {
        viewModel.errorFromServer.sink(receiveValue: {
            isError  in
            if isError {
                showError(errorDescription: NSLocalizedString("ErrorServer", comment: ""))
            }
            
        }).store(in: &bag)
        viewModel.connexion.sink(receiveValue: {
            isError  in
            if isError {
                showError(errorDescription: NSLocalizedString("NoConnection", comment: ""))
            }
            
        }).store(in: &bag)
        viewModel.user.sink(receiveValue: {
            user in
            self.user = user
            print(user)
        }).store(in: &bag)
    }
    
    // MARK: navigation Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    
    @IBAction func connectionAction(_ sender: Any) {
        guard let email = emailTextField.text else {
            return
        }
        guard let psswd = passwordTextField.text else {
            return
        }
        viewModel.email.send(email)
        viewModel.password.send(psswd)
        viewModel.login()
    }
    
}

