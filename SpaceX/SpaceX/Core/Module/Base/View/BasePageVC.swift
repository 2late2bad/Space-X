//
//  BasePageVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol BasePageProtocol: AnyObject {
    
}

final class BasePageVC: UIPageViewController {
    
    // MARK: - Properties
    var router: RocketRouterProtocol!
    var presenter: BasePresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        stylePageControl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutPageControl()
    }
    
    // Test
    var pages: [MainVC] = []
    let initialPage = 0
    
}

// MARK: - Implementation BasePageProtocol
extension BasePageVC: BasePageProtocol {
    
}

// MARK: - Private methods
private extension BasePageVC {
    
    func setup() {
        dataSource = self
//        delegate = self

        view.backgroundColor = Colors.backgroundPageView.uiColor
        additionalSafeAreaInsets.bottom = C.Padding.additionalSafeAreaInsetsBottom
        //
        let page1 = MainVC()
        let page2 = MainVC()
        let page3 = MainVC()
        
        page1.view.backgroundColor = .brown
        page2.view.backgroundColor = .yellow
        page3.view.backgroundColor = .blue
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[initialPage]],
                           direction: .forward,
                           animated: true)

        
    }
    
    func stylePageControl() {
        let pageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = Colors.currentPageIndicator.uiColor
        pageControl.pageIndicatorTintColor = Colors.pageIndicator.uiColor
        pageControl.backgroundColor = .clear
        pageControl.isUserInteractionEnabled = false
    }
    
    func layoutPageControl() {
        view.subviews.forEach { view in
            guard view is UIPageControl else { return }
            view.frame.origin.y = self.view.frame.size.height - C.Padding.additionalPageControlHeight - bottomSafeAreaHeight
            view.setNeedsLayout()
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension BasePageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController as! MainVC) else { return nil }
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController as! MainVC) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        initialPage
    }
}
