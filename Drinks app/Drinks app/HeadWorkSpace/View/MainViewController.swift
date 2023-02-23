//
//  MainViewController.swift
//  Drinks app
//
//  Created by Керемет  on 23/2/23.
//

import Foundation

import UIKit
import SnapKit
import RxSwift
import RxRelay

class CoctailsMenuViewController: UIViewController {
    
    let coctailsMenuViewModel = CoctailsMenuViewModel()
    
    lazy var menuPagesHeader: UILabel = {
        var menuPagesHeader = UILabel()
        menuPagesHeader.text = "Main Dishes"
        menuPagesHeader.textAlignment = .center
        menuPagesHeader.font = .systemFont(ofSize: 26, weight: .semibold)
        menuPagesHeader.textColor = .white
        return menuPagesHeader
    }()
    
    lazy var menuPagesDescription: UILabel = {
        var menuPagesDescription = UILabel()
        menuPagesDescription.text =
        "Find the best selling dishes. All meals are preparred fresh."
        menuPagesDescription.textAlignment = .center
        menuPagesDescription.font = UIFont(name: "Avenir Next", size: 17)
        menuPagesDescription.textColor = .white
        menuPagesDescription.numberOfLines = 0
        return menuPagesDescription
    }()
    
    lazy var menuPagesSearchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchTextField.placeholder = "Find Your Cocktail"
        searchBar.searchTextField.textAlignment = .center
        searchBar.searchTextField.font = UIFont(name: "Avenir Next", size: 17)
        searchBar.searchTextField.layer.cornerRadius = 18
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    lazy var menuCollectionView: UICollectionView = {
        var viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = CGSize(width: 180, height: 250)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .tabBarColor
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setUpCollectionView()
        setUpUI()
        fetchData()
    }
    
    private func fetchData() {
        Task {
            do {
                try await coctailsMenuViewModel.fetchCoctailsData()
                menuCollectionView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func setUpCollectionView() {
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.register(
            CommonCollectionViewCell.self,
            forCellWithReuseIdentifier: CommonCollectionViewCell.reuseID)
    }
    
    private func setUpSubviews() {
        view.addSubview(menuPagesHeader)
        view.addSubview(menuPagesDescription)
        view.addSubview(menuPagesSearchBar)
        view.addSubview(menuCollectionView)
    }
    
    private func setUpConstraints() {
        menuPagesHeader.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().offset(60)
            maker.centerX.equalToSuperview()
        }
      
        menuPagesDescription.snp.makeConstraints{ maker in
            maker.top.equalTo(menuPagesHeader.snp.bottom)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(284)
            maker.height.equalTo(77)
        }
        
        menuPagesSearchBar.snp.makeConstraints{ maker in
            maker.top.equalTo(menuPagesDescription.snp.bottom)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(232)
            maker.height.equalTo(37)
        }
        
        menuCollectionView.snp.makeConstraints{ maker in
            maker.top.equalTo(menuPagesSearchBar.snp.bottom).offset(20)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().inset(0)
        }
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
}


extension CoctailsMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coctailsMenuViewModel.returnCoctailsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.reuseID, for: indexPath) as? CommonCollectionViewCell else { fatalError() }
        let product = coctailsMenuViewModel.returnCoctail(at: indexPath.row)
        cell.displayInfo(product: product)
        return cell
    }
}

extension CoctailsMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coctailVC = DrinksViewController()
        let model = coctailsMenuViewModel.returnCoctail(at: indexPath.row)
        var observe = BehaviorRelay<Drinks>(value: model)
            observe.subscribe(onNext: { drinks in
                coctailVC.coctail = drinks
                print(coctailVC.coctail)
            })
        navigationController?.pushViewController(coctailVC, animated: true)
    }
}

