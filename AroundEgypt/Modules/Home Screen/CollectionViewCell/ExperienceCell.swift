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
    
    
    lazy var likeTapped: (() -> Void)? = nil
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        likeImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped))
        likeImageView.addGestureRecognizer(tapGesture)
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
    
    let recommendedLayerView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        view.layer.cornerRadius = 8.75
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 7
        view.layer.masksToBounds = true
        return view
    }()
    
    var experienceImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo"))
        imageView.render(color: .lightGray)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 7
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let recommendedLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        //GothamMedium(size: 10)
        label.text = "RECOMMENDED"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    
    var recommendedImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.render(color: UIColor(hexString: "#F18757"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        return imageView
    }()
    
    var degreeImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "360"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        return imageView
    }()
    
    var photosImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "multiplePictures"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 21, height: 17)
        return imageView
    }()
    
    var infoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "info.circle"))
        imageView.render(color: .white)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return imageView
    }()
    
    var eyeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "eye"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 10)
        return imageView
    }()
    
    let viewsCountLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        //GothamMedium(size: 14)
        label.text = "30"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        //GothamMedium(size: 14)
        label.text = "Cairo"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()


    
    var likeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "heartEmpty"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 18)
        return imageView
    }()
    
    let likesCountLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        //GothamMedium(size: 14)
        label.text = "30"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    
    
    @objc func likeButtonTapped(){
        if let likeTapped = likeTapped {
            likeTapped()
        }
    }

    
    // MARK: - setup views properties
    
    func setupViews() {
        contentView.addSubview(cellView)
        cellView.addSubview(experienceImage)
        cellView.addSubview(descriptionLabel)
        cellView.addSubview(likeImageView)
        cellView.addSubview(likesCountLabel)
        
        experienceImage.addSubview(degreeImage)
        experienceImage.addSubview(infoImageView)
        experienceImage.addSubview(eyeImageView)
        experienceImage.addSubview(viewsCountLabel)
        experienceImage.addSubview(photosImageView)
        
        experienceImage.addSubview(recommendedLayerView)
        recommendedLayerView.addSubview(recommendedLabel)
        recommendedLayerView.addSubview(recommendedImageView)

        cellView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor,
                        bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        
        experienceImage.anchor(top: cellView.topAnchor, leading: cellView.leadingAnchor,
                        bottom: nil, trailing: cellView.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        experienceImage.constrainHeight(constant: 160)
        
        
        descriptionLabel.anchor(top: experienceImage.bottomAnchor, leading: cellView.leadingAnchor,
                                bottom: cellView.bottomAnchor, trailing: nil,
                        padding: .init(top: 10, left: 5, bottom: 0, right: 0))
        
        likeImageView.anchor(top: experienceImage.bottomAnchor, leading: nil,
                                bottom: cellView.bottomAnchor, trailing: cellView.trailingAnchor,
                        padding: .init(top: 10, left: 0, bottom: 0, right: 5))
        likeImageView.constrainWidth(constant: 20)
        
        
        likesCountLabel.anchor(top: experienceImage.bottomAnchor, leading: nil,
                                bottom: cellView.bottomAnchor, trailing: likeImageView.leadingAnchor,
                        padding: .init(top: 10, left: 0, bottom: 0, right: 7))
        
        degreeImage.constrainWidth(constant: 37)
        degreeImage.constrainHeight(constant: 37)
        degreeImage.centerXInSuperview()
        degreeImage.centerYInSuperview()
        
        
        
        infoImageView.anchor(top: experienceImage.topAnchor, leading: nil,
                                bottom: nil, trailing: experienceImage.trailingAnchor,
                        padding: .init(top: 9, left: 0, bottom: 0, right: 9))
        infoImageView.constrainWidth(constant: 20)
        
        
        
        photosImageView.anchor(top: nil, leading: nil,
                             bottom: experienceImage.bottomAnchor,
                             trailing: experienceImage.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 9, right: 9))
        photosImageView.constrainWidth(constant: 21)
        
        
        eyeImageView.anchor(top: nil,
                            leading: experienceImage.leadingAnchor,
                            bottom: experienceImage.bottomAnchor,
                            trailing: nil,
                            padding: .init(top: 0, left: 9, bottom: 9, right: 0))
        eyeImageView.constrainWidth(constant: 15)
        
        
        viewsCountLabel.anchor(top: nil,
                            leading: eyeImageView.trailingAnchor,
                            bottom: experienceImage.bottomAnchor,
                            trailing: nil,
                            padding: .init(top: 0, left: 9, bottom: 6, right: 0))
        
        
        recommendedLayerView.anchor(top: experienceImage.topAnchor,
                                    leading: experienceImage.leadingAnchor,
                                    bottom: nil,
                                    trailing: nil,
                                    padding: .init(top: 9, left: 9, bottom: 0, right: 0))
        recommendedLayerView.constrainWidth(constant: 111)
        recommendedLayerView.constrainHeight(constant: 18)
        
       
        recommendedImageView.centerYInSuperview()
        recommendedImageView.anchor(top: nil,
                                    leading: recommendedLayerView.leadingAnchor,
                                    bottom: nil,
                                    trailing: nil,
                                    padding: .init(top: 0, left: 5, bottom: 0, right: 0))
        recommendedImageView.constrainWidth(constant: 11)
        
        recommendedLabel.centerYInSuperview()
        recommendedLabel.anchor(top: nil,
                                leading: recommendedImageView.trailingAnchor,
                                bottom: nil,
                                trailing: nil,
                                padding: .init(top: 0, left: 5, bottom: 0, right: 0))
        
    }
    
    
   //MARK: bind function
    
    func bind(_ experience: ExperienceDetailsModel){
        
        ///description
        descriptionLabel.text = experience.title ?? ""
        
        ///views
        viewsCountLabel.text = "\(experience.viewsNo ?? 0)"
        
        ///like
        likesCountLabel.text = "\(experience.likesNo ?? 0)"
        if experience.isLiked ?? false {
            likeImageView.render(color: UIColor(hexString: "#F18757"))
        } else {

        }
        
        if experience.recommended == 1 {
            recommendedLayerView.isHidden = false
        } else {
            recommendedLayerView.isHidden = true
        }
        
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
