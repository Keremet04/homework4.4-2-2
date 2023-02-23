//
//  AddProductsButton.swift
//  Drinks app
//
//  Created by Керемет  on 23/2/23.
//

import Foundation
import UIKit

class AddProductsButton: UIButton {
    
    lazy var basketIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "basket.fill")
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var countView: UIView = {
        var view = UIView()
        view.layer.borderColor = CGColor(red: 255/265, green: 255/265, blue: 255/265, alpha: 1)
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var countLabel: UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var plusIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .white
        return imageView
    }()
    
    lazy var minusIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "minus")
        imageView.tintColor = .white
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(cgColor: CGColor(
                                             red: 250/265,
                                           green: 120/265,
                                            blue: 91/265,
                                           alpha: 1))
        self.layer.cornerRadius = 25
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        self.addSubview(basketIcon)
        self.addSubview(countView)
        countView.addSubview(countLabel)
        countView.addSubview(plusIcon)
        countView.addSubview(minusIcon)
    }
    
    private func setUpConstraints() {
        basketIcon.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().inset(30)
            maker.width.height.equalTo(21)
        }
        
        countView.snp.makeConstraints { maker in
            maker.centerY.centerX.equalToSuperview()
            maker.width.equalTo(75)
            maker.height.equalTo(30)
        }
        
        countLabel.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
            maker.width.height.equalTo(25)
        }
        
        plusIcon.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(5)
            maker.width.height.equalTo(15)
        }
        
        minusIcon.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().inset(5)
            maker.width.height.equalTo(15)
        }
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
}

