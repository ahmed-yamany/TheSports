//
//  LeaguesDetailsTableViewController.swift
//  TheSports
//
//  Created by Ahmed Yamany on 16/08/2022.
//

import UIKit

class LeaguesDetailsTableViewController: UITableViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var badgeImageView: UIImageView!
    
    // MARK: - Properties
    var league: League!
    
    let bannerAndBadgeIndexPath = IndexPath(row: 0, section: 0)
    
    // MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let league = league else{return}
        
        navigationItem.title = league.name
        featchBannerImage()

    }
    // MARK: - IBActions

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Helper Functions
    func featchBannerImage(){
        Task{
            do{
                if let banner = league.banner{
                    print(banner)
                    let featchedImage = try await Request.featchImage(from: banner)
                    league.images.banner = featchedImage
                    updateBannerImageView()
                }
            }catch{
                print("error")
                print(error.localizedDescription)
            }
            
        }
    }
    
    func updateBannerImageView(){
        bannerImageView.image = league.images.banner
        badgeImageView.image = league.images.badge
    }
    
    // MARK: - Table view Delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case bannerAndBadgeIndexPath:
            return 180
        default:
            return tableView.estimatedRowHeight
        }
    }

}
