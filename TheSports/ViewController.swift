//
//  ViewController.swift
//  TheSports
//
//  Created by Ahmed Yamany on 12/08/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task{
            
            let request = Request(.countries)
            
            let sports: Countries = try await request.featchData()
            
            print(sports)
        }
        
    }


}

