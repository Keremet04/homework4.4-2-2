//
//  RankingProductsView.swift
//  Drinks app
//
//  Created by Керемет  on 23/2/23.
//

import Foundation
import UIKit
import SnapKit

class RatingCustomView: UIView {
    
    lazy var profileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    lazy var ratingLabel: UILabel = {
        var label = UILabel()
        label.text = "3.6"
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        return label
    }()
    
    lazy var starImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .orange
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 25
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        self.layer.shadowOpacity = 0.3
        self.backgroundColor = .white
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        self.addSubview(profileImageView)
        self.addSubview(ratingLabel)
        self.addSubview(starImage)
    }
    
    private func setUpConstraints() {
        profileImageView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(10)
            maker.width.height.equalTo(30)
        }
        
        ratingLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalTo(profileImageView.snp.right).offset(50)
            maker.width.equalTo(35)
            maker.height.equalTo(20)
        }
        
        starImage.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalTo(ratingLabel).offset(20)
            maker.width.height.equalTo(18)
        }
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
}

