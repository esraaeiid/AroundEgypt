//
//  HeaderCell.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 07/05/2023.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
 

    // MARK: - Cell Identifier

   static let CellId = "HeaderCell"

    
    // MARK: - Properties
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        //UIColor(hexString: "#F5F5F5")
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    
    let recommendedTitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
            //GothamRoundedBold(size: 22)
        label.text = "Recommended Experiences"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - setup views properties
    
    func setupViews() {
        contentView.addSubview(cellView)
        cellView.addSubview(recommendedTitleLabel)

        cellView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor,
                        bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        recommendedTitleLabel.anchor(top: cellView.topAnchor, leading: cellView.leadingAnchor,
                        bottom: cellView.bottomAnchor, trailing: cellView.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        
    }
    
}
