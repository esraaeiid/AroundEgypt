//
//  HomeView.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import UIKit

class HomeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()

     }
  

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    //MARK:  navigationController items
    
    

   
    
    //MARK:  main collectionView

    lazy var mainCollectionView: UICollectionView =  {
         let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)

        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(hexString: "#F5F5F5")
        collectionView.alwaysBounceVertical = true
        return collectionView
     }()

    

    
    
    //MARK: - setup view
    func setupView(){
    

        //MARK:  main collectionView
        self.addSubview(mainCollectionView)
        mainCollectionView.anchor(top: safeAreaLayoutGuide.topAnchor,
                          leading: leadingAnchor,
                          bottom:  bottomAnchor,
                          trailing: trailingAnchor,
                           padding: .init(top: 0, left: 19, bottom: 0, right: 19))

 
    }
    
}
