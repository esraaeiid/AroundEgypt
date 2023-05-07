//
//  WelcomeCell.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 07/05/2023.
//

import UIKit

class WelcomeCell: UICollectionViewCell {
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
 

    // MARK: - Cell Identifier

   static let CellId = "WelcomeCellID"

    
    // MARK: - Properties
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#F5F5F5")
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    
    
    //MARK:  header containerView
    var headerStackView: UIStackView = {
       var containerView = UIStackView()
        containerView.axis = .vertical
        containerView.spacing = 4
        containerView.distribution = .fillProportionally
        containerView.alignment = .fill
        containerView.backgroundColor = UIColor(hexString: "#F5F5F5")
        return containerView
    }()
    
    let titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
            //GothamRoundedBold(size: 22)
        label.text = "Welcome!"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    let subTitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        //GothamMedium(size: 14)
        label.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        label.attributedText = NSMutableAttributedString(string: "Now you can explore any experience in 360 degrees and get all the details about it all in one place.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    

    
    // MARK: - setup views properties
    
    func setupViews() {
        contentView.addSubview(cellView)
        cellView.addSubview(headerStackView)
        headerStackView.addArrangedSubviews([titleLabel, subTitleLabel])
        
        cellView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor,
                        bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        
     
        

        headerStackView.anchor(top: cellView.topAnchor,
                               leading: cellView.leadingAnchor,
                               bottom: cellView.bottomAnchor,
                               trailing: cellView.trailingAnchor,
                               padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        

        titleLabel.constrainHeight(constant: 25)        
        
    }
    
    


}
