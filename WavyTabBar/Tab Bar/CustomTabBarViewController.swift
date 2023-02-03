//
//  CustomTabBarViewController.swift
//  WavyTabBar
//
//  Created by Shwait Kumar on 03/02/23.
//

import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let tabBar = { () -> CustomTabBar in
            let tabBar = CustomTabBar()
            tabBar.delegate = self
            return tabBar
        }()
        self.setValue(tabBar, forKey: "tabBar")
        
        tabBar.barTintColor = .red
        UITabBar.appearance().clipsToBounds = false
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.itemPositioning = .centered
        
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
        viewControllers = [firstViewController, secondViewController, thirdViewController, fourthViewController]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBar = tabBarController.tabBar as! CustomTabBar
        guard let index = viewControllers?.firstIndex(of: viewController) else {
            return
        }

        tabBar.updateShape(with: index)
    }


}
