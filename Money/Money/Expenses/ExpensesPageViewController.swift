//
//  ExpensesPageViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import UIKit

final class ExpensesPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let pages = [ExpensesPageViewController()]
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! ExpensesPageViewController), index > 0 else {
                    return nil
                }
                return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! ExpensesPageViewController), index < pages.count - 1 else {
                    return nil
                }
                return pages[index + 1]
    }
    
    
}
