//
//  ViewController.swift
//  TheSports
//
//  Created by Ahmed Yamany on 12/08/2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var textLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var startBtnYconstraint: NSLayoutConstraint!
    @IBOutlet weak var startBtnXconstraint: NSLayoutConstraint!
    
    @IBOutlet weak var startButton: Start!

    @IBOutlet weak var guidingImage: UIImageView!
    @IBOutlet weak var guidingImageLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    let startBrnYposition = SCREENHEIGHT / 4
    let startBrnXposition =  -(SCREENWIDTH/4)
    var timer: Timer!
    
    // MARK: - Views
    override func viewWillAppear(_ animated: Bool) {
        let files = Files(request: .leagues)
        let preferedLeagues: [League]! = files.loadModels()
        
        if let preferedLeagues = preferedLeagues, preferedLeagues.count > 0 {
            let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true)
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        playTimer()

    }
    // if returns false the screen will not rotate
    override open var shouldAutorotate: Bool {
            return false
        }
    
    // MARK: - Helper Funtions

    func updateView(){
        UIView.animate(withDuration: 0) {
            // hide elements before animate them
            self.textLeadingConstraint.constant = SCREENWIDTH
            self.startBtnYconstraint.constant = SCREENHEIGHT
            
        } completion: { _ in
            
            self.textLeadingConstraint.constant = 20
            self.startBtnYconstraint.constant = self.startBrnYposition
            self.startBtnXconstraint.constant = self.startBrnXposition
            
            UIView.animate(withDuration: 2) {
                self.view.layoutIfNeeded()
            }
        }
        // add UIPanGestureRecognizer to recognize the moving of the user's finger
        startButton.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handelPanGesture)))
            
        
    }

    func playTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.45, target: self, selector: #selector(self.guidingImageAnimation), userInfo: nil, repeats: true)
        
    }
    
    func viewsDeafultPosition(){
        startBtnXconstraint.constant = startBrnXposition
        guidingImage.alpha = 1
        
    }
    
    // MARK: - IBActions
    @objc func handelPanGesture(gestur: UIPanGestureRecognizer){
        if gestur.state == .began{
            // hide the guiding arrow
            guidingImage.alpha = 0
            
        }else if gestur.state == .changed{ // if finger moves
            // move button with finger moving
            let translation = gestur.translation(in: self.view)
            startBtnXconstraint.constant = translation.x
            
            // if button's position greater than the screen width
            if startButton.frame.midX > SCREENWIDTH{
                // back to deafult position
                viewsDeafultPosition()
                
                // present next ViewController
                let vc = storyboard?.instantiateViewController(withIdentifier: "SportsCollectionViewController")
                navigationController?.pushViewController(vc!, animated: true)
            
            }
            
        }else if gestur.state == .ended{ // if moves ended
            viewsDeafultPosition() // back to deafult position
            
            
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()

            }
        }
    }
    
    @objc func guidingImageAnimation(){
        self.guidingImageLeadingConstraint.constant = 5
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()

        } completion: { _ in
            self.guidingImageLeadingConstraint.constant = -5

            UIView.animate(withDuration: 0.8) {
                self.view.layoutIfNeeded()
            }
        }
        
        
    }
  
    
    
}



