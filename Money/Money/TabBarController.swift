//
//  TabBarController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = .black
        setupViewControllers()
        setupTabBar()
    }
    
    private func setupViewControllers() {
        
        viewControllers = [
            setupNavigationController(rootViewController: ChatViewController(),
                                      title: "Chat",
                                      image: UIImage(systemName: "message") ?? UIImage.add),
            setupNavigationController(rootViewController: ExpensesViewController(),
                                      title: "Expenses",
                                      image: UIImage(systemName: "arrow.down.circle") ?? UIImage.add),
            setupNavigationController(rootViewController: IncomeViewController(),
                                      title: "Income",
                                      image: UIImage(systemName: "arrow.up.circle") ?? UIImage.add),
            setupNavigationController(rootViewController: AnalysisViewController(),
                                      title: "Analysis",
                                      image: UIImage(systemName: "dollarsign.arrow.circlepath") ?? UIImage.add)
        ]
    }
    
    private func setupNavigationController(rootViewController: UIViewController,
                                           title: String,
                                           image: UIImage) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
            
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
//        rootViewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = false
        
        return navigationController
    }
    
    private func setupTabBar() {
        let apperance = UITabBarAppearance()
        apperance.configureWithOpaqueBackground()
        tabBar.scrollEdgeAppearance = apperance
        
        view.tintColor = .black
    }
}

