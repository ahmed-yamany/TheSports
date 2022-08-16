//
//  PreferedLeaguesTableViewCell.swift
//  TheSports
//
//  Created by Ahmed Yamany on 16/08/2022.
//

import UIKit

class PreferedLeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueBadge: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueAlternate: UILabel!
    
    func configure(league: League){
        leagueBadge.image = league.images.badge
        leagueName.text = league.name
        leagueAlternate.text = league.alternate
    }
    
}
