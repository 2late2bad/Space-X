//
//  BasePageVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol BasePageProtocol: AnyObject {
    func success(with rockets: [RocketModel])
    func failure(error: NetworkError)
}

final class BasePageVC: UIPageViewController {
    
    private enum LocalConstants {
        static let additionalSafeAreaInsetsBottom: CGFloat = 12
        static let additionalPageControlHeight: CGFloat = 26
    }
    
    // MARK: - Properties
    var router: RocketRouterProtocol!
    var presenter: BasePresenterProtocol!
    
    private var pages: [UIViewController] = []
    private let initialPage = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        stylePageControl()
        presenter.getPages()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutPageControl()
    }
}

// MARK: - BasePageProtocol Impl
extension BasePageVC: BasePageProtocol {
    
    func success(with rockets: [RocketModel]) {
        for rocketModel in rockets {
            let mainVC = router.routeMainModule(with: rocketModel)
            pages.append(mainVC)
        }
        setPages()
    }
    
    func failure(error: NetworkError) {
        debugPrint(error.message)
        pages = [router.routeEmpty(errorText: error.message)]
        setPages()
    }
}

// MARK: - Private ext
private extension BasePageVC {
    
    func setup() {
        dataSource = self
        view.backgroundColor = Colors.backgroundPageView.uiColor
        additionalSafeAreaInsets.bottom = LocalConstants.additionalSafeAreaInsetsBottom
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
            view.frame.origin.y = self.view.frame.size.height - LocalConstants.additionalPageControlHeight - bottomSafeAreaHeight
            view.setNeedsLayout()
        }
    }
    
    func setPages() {
        setViewControllers([pages[initialPage]],
                           direction: .forward,
                           animated: true)
    }
}

// MARK: - UIPageViewControllerDataSource
extension BasePageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? MainVC,
              let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? MainVC,
              let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
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
