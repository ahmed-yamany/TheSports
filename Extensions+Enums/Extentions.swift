//
//  Extentions.swift
//  TheSports
//
//  Created by Ahmed Yamany on 12/08/2022.
//

import Foundation
import UIKit

extension Dictionary{
    func ConverToQueryItems() -> [URLQueryItem]{
        
    return self.map{
            URLQueryItem(name: ($0.key as! String), value: ($0.value as! String))
        }
        
    }
}


extension UINavigationController {
    
    override open var shouldAutorotate: Bool {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.shouldAutorotate
            }
            return super.shouldAutorotate
        }
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.preferredInterfaceOrientationForPresentation
            }
            return super.preferredInterfaceOrientationForPresentation
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.supportedInterfaceOrientations
            }
            return super.supportedInterfaceOrientations
        }
    }
}
