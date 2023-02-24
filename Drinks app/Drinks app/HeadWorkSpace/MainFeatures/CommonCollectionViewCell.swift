//
//  CommonCollectionView.swift
//  Drinks app
//
//  Created by Керемет  on 23/2/23.
//

import Foundation
import SnapKit
import Kingfisher
import UIKit

class CommonCollectionViewCell: UICollectionViewCell {
    
    var coctails: Drinks?
    
    static var reuseID = String(describing: CommonCollectionViewCell.self)
    
    var productImage: UIImageView! = {
        var foodImage = UIImageView()
        foodImage.contentMode = .scaleAspectFit
        foodImage.layer.cornerRadius = 40
        foodImage.clipsToBounds = true
        return foodImage
    }()
    
    var productlabel: UILabel = {
        var foodName = UILabel()
        foodName.text = "Fried Rice"
        foodName.numberOfLines = 0
        foodName.textAlignment = .center
        foodName.font = UIFont(name: "Avenir", size: 17)
        return foodName
    }()
    
    var productBuyButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(cgColor: CGColor(red: 250/265, green: 120/265, blue:91/265, alpha: 1))
        button.setTitle("Buy now", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .semibold)
        button.layer.cornerRadius = 5
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .tabBarColor
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        self.addSubview(productImage)
        self.addSubview(productlabel)
        self.addSubview(productBuyButton)
    }
    
    private func setUpConstraints() {
        productImage.snp.makeConstraints{ maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(10)
            maker.width.height.equalTo(140)
        }
        
        productlabel.snp.makeConstraints{ maker in
            maker.top.equalTo(productImage.snp.bottom).offset(5)
            maker.centerX.equalTo(productImage)
            maker.width.equalTo(120)
            maker.height.equalTo(50)
        }
        
        productBuyButton.snp.makeConstraints { maker in
            maker.top.equalTo(productlabel.snp.bottom).offset(5)
            maker.centerX.equalTo(productlabel)
            maker.width.equalTo(100)
            maker.height.equalTo(30)
        }
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    func displayInfo(product: Drinks) {
        coctails = product
        productlabel.text = product.strDrink
        productImage.kf.setImage(with: URL(string: product.strDrinkThumb ?? ""))
    }
}
