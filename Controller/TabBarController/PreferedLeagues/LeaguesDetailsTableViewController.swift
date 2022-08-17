//
//  LeaguesDetailsTableViewController.swift
//  TheSports
//
//  Created by Ahmed Yamany on 16/08/2022.
//

import UIKit

class LeaguesDetailsTableViewController: UITableViewController {
    // MARK: - IBOutlets
    // cell at row 0 section 0
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var badgeImageView: UIImageView!{
        didSet{
            badgeImageView.layer.cornerRadius = 30
            badgeImageView.layer.shadowOpacity = 5
            badgeImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
            badgeImageView.layer.shadowColor = UIColor.black.cgColor
            badgeImageView.layer.shadowRadius = badgeImageView.frame.height / 3
        }
    }
    
    @IBOutlet weak var alternateLabel: UILabel!
    // cell at row 1 section 0
    
    @IBOutlet weak var socialMediaCollectionView: UICollectionView!
    
    
    // MARK: - Properties
    var league: League!
    
    let bannerAndBadgeIndexPath = IndexPath(row: 0, section: 0)
    let socialMediaLinksIndexPath = IndexPath(row: 1, section: 0)
    
    // MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let league = league else{return}
        
        UpdateUI(with: league)
        socialMediaCollectionView.delegate = self
        socialMediaCollectionView.dataSource = self
      
    }
    // MARK: - IBActions

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Helper Functions
    
    func UpdateUI(with league: League){
        tableView.allowsSelection = false
        navigationItem.title = league.name
        featchBannerImage()
        badgeImageView.image = league.images.badge
        alternateLabel.text = league.alternate

    }
    
    func featchBannerImage(){
        Task{
            do{
                if let banner = league.banner{
                    let featchedImage = try await Request.featchImage(from: banner)
                    league.images.banner = featchedImage
                }
            }
            bannerImageView.image = league.images.banner
        }
    }
    
    
    // MARK: - Table view Delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case bannerAndBadgeIndexPath:
            return 180
        case socialMediaLinksIndexPath:
            return 40
        default:
            return tableView.estimatedRowHeight
        }
    }

}


extension LeaguesDetailsTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Collection view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        league.socialMediaLinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialMediaCollectionViewCell", for: indexPath) as! SocialMedialCollectionViewCell
        
        let media = league.socialMediaLinks[indexPath.row]
        cell.Image.image = UIImage(named: media["image"]!)
        
        return cell
    }
    
    // MARK: - Collection view FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
}
