//
//  IncomePageViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 23.09.2024.
//

import SnapKit
import UIKit

final class IncomePageViewController: UIPageViewController {
    // MARK: - GUI elements
    let pageControl = UIPageControl(frame: CGRect())
    
    // MARK: - Properties
    var pages: [UIViewController] = [IncomeViewController(viewModel: IncomeViewModel()), IncTransactionsViewController(viewModel: IncTransactionsViewModel())]
    
    // MARK: - Life Cycle
    init() {
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        
        if let incTransactionVC = pages[1] as? IncTransactionsViewController {
            incTransactionVC.delegate = pages[0] as? IncomeViewController
        }
        
        setupPageViewController()
        setupUI()
        setupPageControl()
    }
}

// MARK: - Methods
extension IncomePageViewController {
    func setupUI() {
        view.addSubview(pageControl)
        setupConstraints()
    }
    
    func setupPageViewController() {
        dataSource = self
        delegate = self
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
    }
    
    func setupConstraints() {
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - UIPageViewControllerDelegate
extension IncomePageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            let visibleViewController = pageViewController.viewControllers?.first,
            let index = pages.firstIndex(of: visibleViewController)
        else {
            return
        }
        pageControl.currentPage = index
    }
}

// MARK: - UIPageViewControllerDataSource
extension IncomePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else {
            return nil
        }
        return pages[currentIndex + 1]
    }
}
