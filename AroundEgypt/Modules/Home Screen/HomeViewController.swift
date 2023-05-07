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
    
    var homaPresenation: HomePresenation = .list
    
    //MARK: View LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hexString: "#F5F5F5")
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = HomeViewModel(useCase: HomeUseCase())
        coordinator = .init()
        coordinator?.view = self

        
        viewModel?.recommendedExperiencesRequest()
        viewModel?.recentExperiencesRequest()
        
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
                LoadingView.show()
            } else {
                LoadingView.hide()
            }
        }.store(in: &cancellable)
       
        viewModel?.stateDidUpdate.sink{ [weak self] state in
            guard let self = self else { return }
            self.render(state)
        }.store(in: &cancellable)

        viewModel?.$recommendedExperiencesList.sink{  [weak self] exp in
            guard let self = self else { return }
            self.homeView.mainCollectionView.reloadData()
        }.store(in: &cancellable)
            
        viewModel?.$recentExperiencesList.sink{  [weak self] exp in
            guard let self = self else { return }
            self.homeView.mainCollectionView.reloadData()
        }.store(in: &cancellable)
        
        viewModel?.$searchExperiencesList.sink{  [weak self] exp in
            guard let self = self else { return }
            self.homeView.mainCollectionView.reloadData()
        }.store(in: &cancellable)
        
        viewModel?.$isLiked.sink{  [weak self] exp in
            guard let self = self else { return }
            self.homeView.mainCollectionView.reloadData()
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
    
    
    
    //MARK: - functions
    
    func setup(){
        
        //MARK:- mainCollectionView CollectionView
        homeView.mainCollectionView.delegate = self
        homeView.mainCollectionView.dataSource = self
        homeView.mainCollectionView.register(ExperienceCell.self, forCellWithReuseIdentifier: ExperienceCell.CellId)
        homeView.mainCollectionView.register(RecommendedExperiencesCell.self, forCellWithReuseIdentifier: RecommendedExperiencesCell.CellId)
        
        homeView.mainCollectionView.register(WelcomeCell.self, forCellWithReuseIdentifier: WelcomeCell.CellId)
        
        homeView.mainCollectionView.register(HeaderCell.self,
                                             forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                             withReuseIdentifier: HeaderCell.CellId)
    }


}


// MARK: - ...  UICollectionViewDelegateFlowLayout & UICollectionViewDataSource

extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      
        switch homaPresenation {
        case .search:
            return 1
        case .list:
            return HomeCellType.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch homaPresenation {
            
        case .search:
            return viewModel?.getSearchExperiencesCount() ?? 0
        case .list:
            if section == HomeCellType.welcome.rawValue {
                return 1
            } else if section == HomeCellType.recommended.rawValue {
               return 1
            } else  {
                return viewModel?.getRecentExperiencesCount() ?? 0
            }
        }
    
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch homaPresenation {
        case .search:
            return CGSize(width: collectionView.frame.width, height: 200)
        case .list:
            if indexPath.section == HomeCellType.welcome.rawValue {
                return CGSize(width: collectionView.frame.width, height: 80)
            } else {
                return CGSize(width: collectionView.frame.width, height: 200)
            }
        }
        
           
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch homaPresenation {
        case .search:
            return CGSize(width: collectionView.frame.width, height: 0)
        case .list:
            if section == HomeCellType.welcome.rawValue {
                return CGSize(width: collectionView.frame.width, height: 0)
            } else {
                
                return CGSize(width: collectionView.frame.width, height: 70)
            }
           
        }
     
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

    }
        
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        switch homaPresenation  {
            
        case .search:
            let cell: ExperienceCell = collectionView.dequeueReusableCell(for: indexPath,
                                                                          withReuseId: ExperienceCell.CellId)
            if let experience = self.viewModel?.fetchRecentExperience(at: indexPath.row) {
                cell.bind(experience)
            }
            return cell
            
        case .list:
            if indexPath.section == HomeCellType.welcome.rawValue {
                let cell: WelcomeCell = collectionView.dequeueReusableCell(for: indexPath,
                                                                                          withReuseId: WelcomeCell.CellId)
                return cell
           
                
            } else if indexPath.section == HomeCellType.recommended.rawValue {
                let cell: RecommendedExperiencesCell = collectionView.dequeueReusableCell(for: indexPath,
                                                                                          withReuseId: RecommendedExperiencesCell.CellId)
                
                viewModel?.$recommendedExperiencesList.sink{  [weak self] exp in
                    guard self != nil else { return }
                    cell.recommendedExperiencesCollectionView.reloadData()
                }.store(in: &cancellable)
                
                viewModel?.$isLiked.sink{  [weak self] exp in
                    guard self != nil else { return }
                    cell.recommendedExperiencesCollectionView.reloadData()
                }.store(in: &cancellable)
                
                cell.viewModel = viewModel
                return cell
                
            } else {
                let cell: ExperienceCell = collectionView.dequeueReusableCell(for: indexPath,
                                                                              withReuseId: ExperienceCell.CellId)
                if let experience = self.viewModel?.fetchRecentExperience(at: indexPath.row) {
                    cell.bind(experience)
                    cell.likeTapped = { [weak self] in
                        guard let self = self else { return }
                        if let experienceID = experience.id {
                            print("experienceID", experienceID)
                            self.viewModel?.likeExperienceRequest(with: experienceID)
                        }
                    }
                }
                return cell
            }
            
        }
          
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: HeaderCell.CellId,
                                                                               for: indexPath) as? HeaderCell else {
            assertionFailure("Can't dequeueReusableSupplementaryView")
            return UICollectionReusableView()
        }
        
        if indexPath.section == HomeCellType.recommended.rawValue {
            cell.titleLabel.text = "Recommended Experiences"
            
        } else if indexPath.section == HomeCellType.recents.rawValue {
            cell.titleLabel.text = "Most Recent"
        }
        
        return cell
    }

    
}

