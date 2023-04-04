//
//  MainTabBarController.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = UIColor(red: 195/255, green: 196/255, blue: 201/255, alpha: 1).cgColor
        tabBar.layer.borderWidth = 1
        tabBar.tintColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 0.765, green: 0.77, blue: 0.788, alpha: 1)
        viewControllers = [
            setupTabBarItem(with: MenuViewController(), title: "Меню", image: UIImage(named: "menu")),
            setupTabBarItem(with: UIViewController(), title: "Контакты", image: UIImage(named: "contact")),
            setupTabBarItem(with: UIViewController(), title: "Профиль", image: UIImage(named: "profile")),
            setupTabBarItem(with: UIViewController(), title: "Корзина", image: UIImage(named: "bag"))
        ]
    }
    
    private func setupTabBarItem(with vc: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
        return navigationController
    }

}
