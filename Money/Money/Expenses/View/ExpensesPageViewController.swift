//
//  ExpensesPageViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import UIKit
import SnapKit

final class ExpensesPageViewController: UIPageViewController {

    // MARK: - UI elements
    // не нужен экземпляр второго UIPageViewController тк твой класс уже им является, выше наследуется
    // private let
    private let pageControl = UIPageControl(frame: CGRect())

    // MARK: - Properties

    // временно взяты одинаковые контроллеры, для наглядности
    private let pages = [
        ExpensesViewController(viewModel: ExpensesViewModel()),
        ExpensesViewController(viewModel: ExpensesViewModel())
    ]
    
    // MARK: - Life Cycle

    init() {
        super.init(transitionStyle: .scroll, // тк контроллер уже наследуется от UIPageViewController, что бы изменить тип прокрутки добавим настройку в инит
                   navigationOrientation: .horizontal,
                   options: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPageViewController()
        setupUI()
        setupPageControl()
    }
}

// MARK: - Private
// Приватные методы можно вынести в приватный экстеншн, теперь все будут в одном месте,
// а самим функциям не нужно объявлять модификатор доступа

private extension ExpensesPageViewController {

    // Разграничивай настройку юая создание констрейнтов в разных методах, потом сложно будет искать где что конфигурится
    // Идеально - одна функция - одна ответственность
    func setupUI() {
        view.addSubview(pageControl)
        setupConstraints()
    }

    func setupPageViewController() {
        dataSource = self
        delegate = self

        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }

    func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        // Если используешь снапкит translatesAutoresizingMaskIntoConstraints не нужен, он реализован в библиотеке
    }

    func setupConstraints() {
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.centerX.equalToSuperview()
        }
    }
}

// Хорошая практика делегаты выносить в экстеншн контроллера, более читабельный и управляемый код
// MARK: - UIPageViewControllerDelegate

extension ExpensesPageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            let visibleViewController = pageViewController.viewControllers?.first,
            let expensesViewController = visibleViewController as? ExpensesViewController, // никаких форсанрапов!
            let index = pages.firstIndex(of: expensesViewController)
        else {
            return
        }

        pageControl.currentPage = index
    }
}

// MARK: - UIPageViewControllerDataSource

extension ExpensesPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let expensesViewController = viewController as? ExpensesViewController,
            let index = pages.firstIndex(of: expensesViewController),
            index > 0
        else {
            return nil
        }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let expensesViewController = viewController as? ExpensesViewController,
            let index = pages.firstIndex(of: expensesViewController),
            index < pages.count - 1
        else {
            return nil
        }
        return pages[index + 1]
    }
}
