//
//  LeaguesTableViewController.swift
//  TheSports
//
//  Created by Ahmed Yamany on 15/08/2022.
//

import UIKit

class LeaguesTableViewController: UITableViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var nextbarButton: UIBarButtonItem!
    
    
    // MARK: - Properties
    var sport: Sport!
    var country: Country!
    
    var leagues: [League] = []
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    var selectedLeague: League!

    // MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()

        nextbarButton.isEnabled = false
        
        indicator.center = view.center  // make indicator at the view's center
        indicator.startAnimating()      // start indicator
        view.addSubview(indicator)      // add indicator to the view
        
        leaguesNetworkRequest()         // start network request

    }

    // MARK: - IBActions

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        guard let selectedLeague = selectedLeague else{return}
        
        let files = Files(request: .leagues)
        
        let preferedLeagues: [League]! = files.loadModels()
        
        if let preferedLeagues = preferedLeagues{
            if !preferedLeagues.contains(selectedLeague){
            
                let newLeagues = preferedLeagues + [selectedLeague]
                files.saveToFiles(newLeagues)
            }
        }else{
            files.saveToFiles([selectedLeague])
        }

        let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)


        
        
    }
    
    // MARK: - Helper Functions
    func leaguesNetworkRequest(){
        Task{
            do{
                guard let sport = sport, let country = country else{return}

                let queries = ["s": sport.name, "c": country.name].ConverToQueryItems()
                
                let request = Request(.leagues, queryItems: queries)
                let LeaguesRequest: Leagues = try await request.featchData()
                if let LeaguesRequest = LeaguesRequest.leagues{
                    leagues = LeaguesRequest
                    featchLeaguesBadgeImage()
                }
                if leagues.count > 0{
                    navigationItem.title = "\(country.name) Leagues"
                }else{
                    navigationItem.title = "\(country.name) doesn't have leagues"
                }
                tableView.reloadData()
                self.indicator.stopAnimating()      // stop indicator
                                
            }catch{
                print(error.localizedDescription)
                self.navigationItem.title = "You apper to be offline"
            }
            
//            let files = Files(request: .leagues)
//            files.saveToFiles(self.leagues)
        }
    }
    
    func featchLeaguesBadgeImage(){
        for leagueIndex in 0...leagues.count-1{
            Task{
                do{
                    let league = leagues[leagueIndex] // league at indexPath
                    if let badge = league.badge{
                        let image = try await Request.featchImage(from: badge) // featch League badge image
                        self.leagues[leagueIndex].images.badge = image // update league badge image
                        
                        tableView.reloadRows(at: [IndexPath(row: leagueIndex, section: 0)], with: .none)
                    }
                    
                }catch{
                 
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesTableViewCell", for: indexPath) as! LeaguesTableViewCell
        let league = leagues[indexPath.row]
        // Configure the cell...
        cell.selectionStyle = .none
        cell.badge.image = league.images.badge
        cell.name.text = league.name
        
        if let selectedLeague = selectedLeague{
            if selectedLeague.id == league.id{
                cell.isCellSelected = true
            }else{
                cell.isCellSelected = false
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLeague = leagues[indexPath.row]
        nextbarButton.isEnabled = true
        tableView.reloadData()
    }
    
    
    
    
}
