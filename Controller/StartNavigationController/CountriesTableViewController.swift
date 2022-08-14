//
//  CountriesTableViewController.swift
//  TheSports
//
//  Created by Ahmed Yamany on 14/08/2022.
//

import UIKit

class CountriesTableViewController: UITableViewController, UISearchBarDelegate{
    // MARK: - IBOutlets

    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var countries: [Country] = []
    var filteredCountries: [Country] = []
    var sport: Sport!
    var selectedCountry: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBarButton.isEnabled = false
        searchBar.delegate = self
        self.tableView.keyboardDismissMode = .onDrag
        countriesNetworkRequest()
        
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(66)
//        searchBar.endEditing(true)

    }
    
    // MARK: - IBActions
    
    @IBAction func backBarButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBarButtonTapped(_ sender: UIBarButtonItem) {
        
    
    }
    
    
    
    // MARK: - Helper Functions
    func countriesNetworkRequest(){
        Task{
            do{
                let request = Request(.countries)
                let countriesRequest: Countries = try await request.featchData()
                
                self.countries = countriesRequest.countries
                filteredCountries = countries

                tableView.reloadData()
                
            }catch{
                print(error.localizedDescription)
                
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
        return filteredCountries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesTableViewCell", for: indexPath) as! CountriesTableViewCell
        cell.selectionStyle = .none
        let countrie = filteredCountries[indexPath.row]
        // Configure the cell...
        cell.name.text = countrie.name
        
        if let selectedCountry = selectedCountry{
            if countrie.name == selectedCountry.name{
                cell.isCellSelected = true
            }else{
                cell.isCellSelected = false
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCountry = filteredCountries[indexPath.row]
        nextBarButton.isEnabled = true
        tableView.reloadData()
    }
    
    
    // MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty{
            filteredCountries = countries
        }else{
        filteredCountries = []
        
        for country in countries {
            if country.name.lowercased().contains(searchText.lowercased()){
                filteredCountries.append(country)
            }
        }
        }
        
        tableView.reloadData()
        
    }


}
