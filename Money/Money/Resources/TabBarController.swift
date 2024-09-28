//
//  TabBarController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = .black
        setupViewControllers()
        setupTabBar()
    }
    
    // MARK: - Private
    private func setupViewControllers() {
        
        viewControllers = [
            setupNavigationController(rootViewController: CurrencyViewController(viewModel: CurrencyViewModel()),
                                      title: "Currency".localized,
                                      image: UIImage(systemName: "dollarsign.arrow.circlepath") ?? UIImage.add),
            setupNavigationController(rootViewController: ExpensesPageViewController(),
                                      title: "Expenses".localized,
                                      image: UIImage(systemName: "arrow.down.circle") ?? UIImage.add),
            setupNavigationController(rootViewController: IncomePageViewController(),
                                      title: "Income".localized,
                                      image: UIImage(systemName: "arrow.up.circle") ?? UIImage.add)
        ]
    }
    
    private func setupNavigationController(rootViewController: UIViewController,
                                           title: String,
                                           image: UIImage) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = false
        
        return navigationController
    }
    
    private func setupTabBar() {
        self.selectedIndex = 1
        let apperance = UITabBarAppearance()
        apperance.configureWithOpaqueBackground()
        tabBar.scrollEdgeAppearance = apperance
        
        view.tintColor = .black
    }
}

