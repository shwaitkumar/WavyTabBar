//
//  CustomTabBarViewController.swift
//  WavyTabBar
//
//  Created by Shwait Kumar on 03/02/23.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    let waveView = WaveView(trough: 40)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tabBar.backgroundColor = .white

        // Create the first view controller
        let firstViewController = ViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "house"), tag: 0)

        // Create the second view controller
        let secondViewController = SecondViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "cloud.drizzle.circle"), tag: 1)

        // Create the third view controller
        let thirdViewController = ThirdViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "gauge.low"), tag: 2)

        // Create the fourth view controller
        let fourthViewController = FourthViewController()
        fourthViewController.tabBarItem = UITabBarItem(title: "Fourth", image: UIImage(systemName: "poweroutlet.type.f"), tag: 3)

        // Add the view controllers to the tab bar controller
        self.viewControllers = [firstViewController, secondViewController, thirdViewController, fourthViewController]
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let shouldAnimate: Bool

        if waveView.superview != view {
            view.insertSubview(waveView, at: 1)
            shouldAnimate = false
        } else {
            shouldAnimate = true
        }

        let tabBar = self.tabBar
        let w: CGFloat

        if let selected = tabBar.selectedItem, let items = tabBar.items {
            w = (CGFloat(items.firstIndex(of: selected) ?? 0) + 0.5) / CGFloat(items.count) - 1
        } else {
            w = -1
        }

        let trough = waveView.trough
        let tabBarFrame = view.convert(tabBar.bounds, from: tabBar)
        let waveFrame = CGRect(
//            x: tabBarFrame.origin.x + tabBarFrame.size.width * w,
//            y: tabBarFrame.origin.y - trough,
//            width: 2 * tabBarFrame.size.width,
//            height: tabBarFrame.size.height + trough
            
            x: tabBarFrame.origin.x + tabBarFrame.size.width * w,
            y: tabBarFrame.origin.y - 1.33 * trough, // pull shape a little above on y-axis
            width: 2 * tabBarFrame.size.width,
            height: tabBarFrame.size.height + 1.33 * trough // increase height so the space at bottom alos fills if you pull shape above on y-axis
        )

        guard waveFrame != waveView.frame else {
            return
        }

        if shouldAnimate {
            // Don't animate during the layout pass.
            DispatchQueue.main.async { [waveView] in
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
                    waveView.frame = waveFrame
                }
            }
        } else {
            waveView.frame = waveFrame
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if superclass!.instancesRespond(to: #selector(UITabBarDelegate.tabBar(_:didSelect:))) {
            super.tabBar(tabBar, didSelect: item)
        }
        view.setNeedsLayout()
    }

}
