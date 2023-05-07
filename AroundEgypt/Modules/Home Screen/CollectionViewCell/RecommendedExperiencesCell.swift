//
//  ExperiencesCell.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 07/05/2023.
//

import UIKit

class RecommendedExperiencesCell: UICollectionViewCell {
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
 
    // MARK: - Cell Identifier

   static let CellId = "RecommendedExperiencesCellID"
    
    
    // MARK: - Properties
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        //UIColor(hexString: "#F5F5F5")
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    
    lazy var recommendedExperiencesCollectionView: UICollectionView =  {
         let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)

        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(hexString: "#F5F5F5")
        return collectionView
     }()
    
    

    
    // MARK: - setup views properties
    
    func setupViews() {
        contentView.addSubview(cellView)
        cellView.addSubview(recommendedExperiencesCollectionView)

        cellView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor,
                        bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        recommendedExperiencesCollectionView.anchor(top: cellView.topAnchor,
                                                    leading: cellView.leadingAnchor,
                                                    bottom: cellView.bottomAnchor,
                                                    trailing: cellView.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    //MARK: - functions
    
    func setupCollectionView(){
        //MARK:- recommendedExperiences CollectionView
        recommendedExperiencesCollectionView.delegate = self
        recommendedExperiencesCollectionView.dataSource = self
        recommendedExperiencesCollectionView.register(ExperienceCell.self, forCellWithReuseIdentifier: ExperienceCell.CellId)
        
    }
    
    
}



// MARK: - ...  UICollectionViewDelegateFlowLayout & UICollectionViewDataSource

extension RecommendedExperiencesCell : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return 4
   
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            return CGSize(width: collectionView.frame.width, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
               
    }
        
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell: ExperienceCell = collectionView.dequeueReusableCell(for: indexPath,
                                                                          withReuseId: ExperienceCell.CellId)
            return cell
        
          
    }

    
}



