//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Adair on 13/07/2020.
//  Copyright © 2020 Michael Adair. All rights reserved.
//

import UIKit

// This is the list view controller on the front page
// It inherits from UITableViewController and UISearchBarDelegate
class PokemonListViewController: UITableViewController, UISearchBarDelegate {
    
    // This is our Pokemon, returned from the results - from the Pokemon Models.
    var pokemon: [PokemonListResult] = []
        
    // Creates an outlet for our Searchbar to link this controller to the storyboard
    @IBOutlet var searchBar: UISearchBar!
    
    
    // A function to capitalise the first letter of words returned from the API
    func capitalise(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    
    // We take Swift's viewDidLoad function and override it to pass new arguments to it
    override func viewDidLoad() {
        
        // We call the superClass for viewDidLoad
        super.viewDidLoad()
        
        
        // guard allows us to handle url even if it is null
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else {
            return
        }
        
        // we use the URL to fetch
        // dataTask is the method that fetches
        // we then set the data from the response
        // this method needs to be concluded with the .resume() method.
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            
            do {
                let entries = try JSONDecoder().decode(PokemonListResults.self, from: data)
                self.pokemon = entries.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = capitalise(text: pokemon[indexPath.row].name)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokemonSegue",
                let destination = segue.destination as? PokemonViewController,
                let index = tableView.indexPathForSelectedRow?.row {
            destination.url = pokemon[index].url
        }
    }
}

