//
//  LeaguesTableViewCell.swift
//  TheSports
//
//  Created by Ahmed Yamany on 15/08/2022.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var badge: UIImageView!
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

    
}
