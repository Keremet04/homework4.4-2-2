//
//  TabBarController.swift
//  Drinks app
//
//  Created by Керемет  on 23/2/23.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    func generateTabBar() {
        viewControllers = [
            generateVC(viewcontroller: ProfileViewController(),
                       image: UIImage(systemName: "person")),
            generateVC(viewcontroller: CoctailsMenuViewController(),
                       image: UIImage(systemName: "house")),
            generateVC(viewcontroller: GetDrinksViewController(),
                       image: UIImage(systemName: "cart"))
        ]
    }
    
    private func generateVC(
        viewcontroller: UIViewController,
        image: UIImage?) -> UIViewController{
            viewcontroller.tabBarItem.image = image
            return viewcontroller
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController{
        viewController.tabBarItem.image = image
        return viewController
    }
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        roundLayer.fillColor = UIColor.tabBarColor.cgColor
        tabBar.tintColor = .tabBarItemLight
        tabBar.unselectedItemTintColor = .tabBarItemColor
    }
}

