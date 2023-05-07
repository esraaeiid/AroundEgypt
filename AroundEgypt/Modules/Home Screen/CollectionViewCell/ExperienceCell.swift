//
//  ExperienceCell.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import UIKit
import Combine


class ExperienceCell: UICollectionViewCell {
    
    //MARK: Cell Identifier
    
    static let CellId = "ExperienceCellID"
    
    //MARK: Vars
    
    var imageLoader: ImageLoader?
    var cancellable: [AnyCancellable] = []
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
 
    
    // MARK: - Properties
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#F5F5F5")
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 7
        view.layer.masksToBounds = true
        return view
    }()
    
    
    var experienceImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo"))
        imageView.render(color: .lightGray)
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    

    
    // MARK: - setup views properties
    
    func setupViews() {
        contentView.addSubview(cellView)
        cellView.addSubview(experienceImage)

        cellView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor,
                        bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        
        experienceImage.anchor(top: cellView.topAnchor, leading: cellView.leadingAnchor,
                        bottom: cellView.bottomAnchor, trailing: cellView.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    
    
    func bind(_ experience: ExperienceDetailsModel){
        
        
        ///Image
        if let url = experience.coverPhoto, let experienceID = experience.id {
         imageLoader = ImageLoader(url: url,
                                   photoID: experienceID)
        }

        guard imageLoader != nil else {
            return
        }

        imageLoader?.$image.sink { [weak self] img in
            guard let self = self else { return }

            if img != nil {
                self.experienceImage.image = img
                self.imageLoader = nil
            }

        }.store(in: &cancellable)
        
    }


    

    
}
