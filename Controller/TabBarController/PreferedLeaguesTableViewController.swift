//
//  PreferedLeaguesTableViewController.swift
//  TheSports
//
//  Created by Ahmed Yamany on 16/08/2022.
//

import UIKit

class PreferedLeaguesTableViewController: UITableViewController {
    // MARK: - IBOutlets

    
    // MARK: - Properties
    var preferedLeagues: [League] = []
    
    
    // MARK: - Views

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let files = Files(request: .leagues)
        let leagues: [League]! = files.loadModels()
        
        if let leagues = leagues{
            preferedLeagues = leagues
            featchLeaguesBadge()
        }
        
    }
    // MARK: - IBActions
    
    @IBAction func addLeagueTapped(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SportsCollectionViewController")
        navigationController?.pushViewController(vc!, animated: true)
    
        
    }
    
    
    
    // MARK: - Helper Functions
    func featchLeaguesBadge(){
        for leagueIndex in 0..<preferedLeagues.count{
            Task{
                if let badge = preferedLeagues[leagueIndex].badge{
                    do{
                        preferedLeagues[leagueIndex].images.badge = try await Request.featchImage(from: badge)
                        tableView.reloadRows(at: [IndexPath(row: leagueIndex, section: 0)], with: .none)

                    }catch{
                        preferedLeagues[leagueIndex].images.badge = UIImage(systemName: "exclamationmark.octagon")
                        }
                    tableView.reloadData()

                }
                }
            }
        }
    



    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
  
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return preferedLeagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreferedLeaguesTableViewCell", for: indexPath) as! PreferedLeaguesTableViewCell

        // Configure the cell...
        cell.selectionStyle = .none
        
        cell.configure(league: preferedLeagues[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            preferedLeagues.remove(at: indexPath.row)
            
            let files = Files(request: .leagues)
            files.saveToFiles(preferedLeagues)

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
}
