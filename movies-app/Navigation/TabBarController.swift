//
//  TabBarViewController.swift
//  delivery-food-app
//
//  Created by Eugene on 13.06.23.
//

import UIKit

private struct NavigationController {
    var image: String
    var selectedImage: String
    var tabBarTitle: String
    var screen: UIViewController
}

fileprivate var screenFactory = DependencyContainer.shared.screenFactory

private var controllers: [NavigationController] = [
    NavigationController(image: "film", selectedImage: "film.fill", tabBarTitle: "Movies", screen: screenFactory.createMoviesController()),
    NavigationController(image: "magnifyingglass", selectedImage: "magnifyingglass", tabBarTitle: "Search", screen: screenFactory.createSearcMovieshController()),
    NavigationController(image: "bookmark", selectedImage: "bookmark.fill", tabBarTitle: "Watch list", screen: screenFactory.createFavoritesMoviesController())
]

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupTabBarAppearance()
    }
}

extension TabBarController {
    private func setupTabBar() {
        var navigationControllers: [UINavigationController] = []
        
        for controller in controllers {
            let navigationController = setupUINavigationController(controller)

            navigationControllers.append(navigationController)
        }
        
        tabBar.tintColor = .darkBlue
        tabBar.unselectedItemTintColor = .purpleGray
        
//        tabBar.layer.masksToBounds = false
//        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
//        tabBar.layer.shadowRadius = 2
//        tabBar.layer.shadowColor = UIColor.black.cgColor
//        tabBar.layer.shadowOpacity = 0.3
        
        
        viewControllers = navigationControllers
    }
    
    private func setupUINavigationController(_ controller: NavigationController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller.screen)
        
        let image = UIImage(systemName: controller.selectedImage)
        let selectedImage = UIImage(systemName: controller.selectedImage)
        
        let tabItem = UITabBarItem(title: controller.tabBarTitle, image: selectedImage, selectedImage: image)

        navigationController.tabBarItem = tabItem
        
        return navigationController
    }
    
    private func setupTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        tabBar.tintColor = .darkBlue
        tabBar.unselectedItemTintColor = .purpleGray // appearance перекрывает цвет
    }
    
//    private func setupNavBarApperance(_ controller: UINavigationController) {
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.configureWithDefaultBackground()
//
//        controller.navigationBar.standardAppearance = navBarAppearance
//        controller.navigationBar.compactAppearance = navBarAppearance
//        controller.navigationBar.scrollEdgeAppearance = navBarAppearance
//    }
}
