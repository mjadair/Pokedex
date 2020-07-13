//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Adair on 13/07/2020.
//  Copyright © 2020 Michael Adair. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let pokemon = [
        Pokemon(name: "Bulbasaur", number: 1),
        Pokemon(name: "Ivysaur", number: 2),
        Pokemon(name: "Venasaur", number: 3)
    ]

    override func numberOfSections(in tableView: UITableView) -> Int {
     return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        cell.textLabel?.text = pokemon[indexPath.row].name
        
        return cell
        
    }


}

