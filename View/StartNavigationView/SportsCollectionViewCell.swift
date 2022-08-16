//
//  SportsCollectionViewCell.swift
//  TheSports
//
//  Created by Ahmed Yamany on 14/08/2022.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var selectedCellImage: UIImageView!
    
    var isCellSelected: Bool = false{
        didSet{
            if isCellSelected{
                selectedCellImage.image = UIImage(systemName: "checkmark.circle")
                selectedCellImage.tintColor = UIColor(named: "ButtonBG")
            }else{
                selectedCellImage.image = nil
            }
        }
    }
    
    
    func configure(sport: Sport){
        if let image = sport.iconImage{     // change cell image to sport's icon image
            self.image.image = image
        }
        
        self.name.text = sport.name // change cell label to sport's name
        
    }
}
