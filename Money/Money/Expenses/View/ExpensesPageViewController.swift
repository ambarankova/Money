//
//  ExpensesPageViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import UIKit
import SnapKit

final class ExpensesPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // MARK: - Properties
    var pageViewController = UIPageViewController()
    var pageControl = UIPageControl(frame: CGRect())
    // временно взяты одинаковые контроллеры, для наглядности
    let pages = [
        ExpensesViewController(viewModel: ExpensesViewModel()),
        ExpensesViewController(viewModel: ExpensesViewModel())
    ]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageViewController()
        setupPageControl()
    }
    
    // MARK: - Private Methods
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        pageViewController.setViewControllers([pages[0]],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        pageViewController.view.frame = view.bounds
        view.addSubview(pageViewController.view)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! ExpensesViewController), index > 0 else {
                    return nil
                }
                return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! ExpensesViewController), index < pages.count - 1 else {
                    return nil
                }
                return pages[index + 1]
    }
    
    // MARK: - UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if let visibleViewController = pageViewController.viewControllers?.first,
               let index = pages.firstIndex(of: visibleViewController as! ExpensesViewController) {
                pageControl.currentPage = index
            }
        }
}
