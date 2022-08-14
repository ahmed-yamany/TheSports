//
//  SportsCollectionViewController.swift
//  TheSports
//
//  Created by Ahmed Yamany on 14/08/2022.
//

import UIKit

private let reuseIdentifier = "SportsCollectionViewCell"

class SportsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    var sports: [Sport] = []
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    // MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sports You may prefer"
        
        indicator.center = view.center  // make indicator at the view's center
        indicator.startAnimating()      // start indicator
        view.addSubview(indicator)      // add indicator to the view
        
        sportsNetworkRequest()      // start network request
    }
    
    // MARK: Helper Fuctions
    // a function that featches sports
    func sportsNetworkRequest(){
        Task{
            do{
                let request = Request(.sports)
                let requestData: Sports = try await request.featchData()    // featch sports
                
                self.sports = requestData.sports    // add featched sports to sports array
                
                featchSportsIconImage()             // featch sports icons
                self.indicator.stopAnimating()      // stop indicator

                
            }catch{
                self.navigationItem.largeTitleDisplayMode = .never
                self.navigationItem.title = "You apper to be offline"
            }
            
            let files = Files(request: .sports)         // save sports to a file
            files.saveToFiles(self.sports)
        }
    }
    // a function that featches sports iconImage
    func featchSportsIconImage(){
        // featch sports iconImage
        for sportIndex in 0...self.sports.count - 1{
            Task{
                do{
                    let sport = self.sports[sportIndex] //  sport at indexPath
                    let image = try await Request.featchImage(from: sport.icon) // featch sport icon image
                    self.sports[sportIndex].iconImage = image   // update sport icon image

                    collectionView.reloadItems(at: [IndexPath(row: sportIndex, section: 0)])    // reload cell at indexPath
                }catch{

                    self.sports[sportIndex].iconImage = UIImage(systemName: "exclamationmark.octagon")
                    
                    
                }
            }
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SportsCollectionViewCell
        let sport = sports[indexPath.row]
        // Configure the cell
        
        if let image = sport.iconImage{
            cell.image.image = image
        }
        
        cell.name.text = sport.name
        
    
        return cell
    }

    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREENWIDTH/3) - 10, height: (SCREENHEIGHT/6))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    
}