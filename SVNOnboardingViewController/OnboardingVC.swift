//
//  OnboardingVC.swift
//  Deedz
//
//  Created by Aaron Dean Bikis on 4/28/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNTheme
import SVNShapesManager
import SVNModalViewController

open class OnboardingViewController: SVNModalViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  
  open var imageFileNames: [String]
  
  private lazy var pageViewController: UIPageViewController = self.pageVCFactory()
  
  private lazy var pageControl: UIPageControl = self.pageControlFactory()
  
  public var currentIndex: Int {
    get {
      return orderedViewControllers.index(of: pageViewController.viewControllers!.first!)!
    }
  }
  
  private lazy var orderedViewControllers: [UIViewController] = {
    
    var vcs = [UIViewController]()
    for image in self.imageFileNames {
      vcs.append(OnboardingContentViewController(imageName: image))
    }
    return vcs
  }()
  
  private func pageVCFactory() -> UIPageViewController {
    
    let vc = UIPageViewController(transitionStyle: .scroll,
                                  navigationOrientation: .horizontal, options: nil)
    vc.dataSource = self
    vc.delegate = self
    return vc
  }
  
  
  private func pageControlFactory() -> UIPageControl {
    
    let pc = UIPageControl()
    pc.currentPage = 0
    pc.backgroundColor = theme.primaryDialogColor
    pc.pageIndicatorTintColor = .black
    pc.layer.shadowOffset = CGSize(width: 0, height: -5)
    pc.layer.shadowColor = UIColor.black.cgColor
    pc.layer.shouldRasterize = true
    pc.layer.masksToBounds = false
    pc.layer.shadowOpacity = 0.5
    pc.layer.shadowRadius = 5
    pc.isUserInteractionEnabled = false
    pc.currentPageIndicatorTintColor = .white
    pc.numberOfPages = imageFileNames.count
    return pc
  }
  
  
  public init(theme: SVNTheme, imageFileNames: [String]){
    self.imageFileNames = imageFileNames
    super.init(nibName: nil, bundle: nil)
    self.theme = theme
  }
  
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    UIApplication.shared.statusBarStyle = .default
    view.backgroundColor = .white
    addChildViewController(pageViewController)
    pageViewController.didMove(toParentViewController: self)
    view.addSubview(pageViewController.view)
    pageViewController.view.addSubview(pageControl)
    addModalSubviews()
    if let firstViewController = orderedViewControllers.first {
      pageViewController.setViewControllers([firstViewController],
                                            direction: .forward,
                                            animated: true,
                                            completion: nil)
    }
  }
  
  
  override open func viewDidLayoutSubviews() {
    
    pageViewController.view.frame = view.bounds
    pageControl.frame = CGRect(x: 0, y: view.frame.height - 55, width: view.frame.width, height: 55)
    dismissButton.frame = CGRect(x: view.frame.width - (35 + 15), y: 45, width: 35, height: 35)
  }
  
  
  // MARK: - PageViewController DataSource
  public func pageViewController(_ pageViewController: UIPageViewController,
                                 viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    let previousIndex = currentIndex - 1
    
    guard previousIndex >= 0,
      orderedViewControllers.count > previousIndex else {
        return nil
    }
    
    return orderedViewControllers[previousIndex]
  }
  
  
  public func pageViewController(_ pageViewController: UIPageViewController,
                                 viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    let nextIndex = currentIndex + 1
    
    guard orderedViewControllers.count != nextIndex,
      orderedViewControllers.count > nextIndex  else {
        return nil
    }
    
    return orderedViewControllers[nextIndex]
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                                 previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    
    pageControl.currentPage = currentIndex
  }
}
