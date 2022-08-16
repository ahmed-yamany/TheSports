//
//  TabBarViewController.swift
//  TheSports
//
//  Created by Ahmed Yamany on 15/08/2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tabBar.tintColor = UIColor(named: "ButtonBG")
    }
}


class TabBar: UITabBar{
    override func layoutSubviews() {
        super.layoutSubviews()

        if let tabBarItem = self.items?[0]{
            tabBarItem.image = UIImage(systemName: "house")
            tabBarItem.selectedImage = UIImage(systemName: "house.fill")
    
            tabBarItem.title = "Home"
        }
        if let tabBarItem = self.items?[1]{
            tabBarItem.image = UIImage(systemName: "sportscourt")
            tabBarItem.selectedImage = UIImage(systemName: "sportscourt.fill")
        }
        
        
       
    }
}
