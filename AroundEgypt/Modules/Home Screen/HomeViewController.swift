//
//  HomeViewController.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import UIKit

class HomeViewController: BaseViewController<HomeViewModel> {

    
    //MARK: Vars
    var coordinator: HomeCoordinator?
    var homeView = HomeView()
    
    
    //MARK: View LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .yellow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = HomeViewModel(useCase: HomeUseCase())
        coordinator = .init()
        coordinator?.view = self
        
        //        viewModel?.recommendedExperiencesRequest()
        //        viewModel?.recentExperiencesRequest()
        
        //        viewModel?.likeExperienceRequest(with: "94a6e522-0e6a-480d-b70b-9bffd0068f11")
        //        viewModel?.likeExperienceRequest(with: "Nefertari")
        //        viewModel?.singleExperienceRequest(with: "94a6e522-0e6a-480d-b70b-9bffd0068f11")
        self.view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tessst))
        view.addGestureRecognizer(tap)
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
        
    }
    
    override func loadView() {
        view = homeView
    }

    @objc func tessst(){
        coordinator?.presentExperience(with: "")
    }
    
    
    override func bind() {
        super.bind()
        viewModel?.$isLoading.sink{ isLoading in
            print("...\(isLoading)...")
            if isLoading {
               
            } else {
                
            }
        }.store(in: &cancellable)
       
        viewModel?.stateDidUpdate.sink{ [weak self] state in
            guard let self = self else { return }
            self.render(state)
        }.store(in: &cancellable)
        
        
        viewModel?.$recommendedExperiencesList.sink{  [weak self] exp in
            guard let self = self else { return }
            //reload collectionView
        }.store(in: &cancellable)
    }
    
    
    
    private func render(_ state: HomeViewModelState){
        switch state {
        case .show(let isFetched):
            print("experiences 😍", isFetched)
            
        case .error(let errorMessage):
            print("error 😭 \(errorMessage) 😭")
        }
    }


}

