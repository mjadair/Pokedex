//
//  pokemonViewController.swift
//  Pokedex
//
//  Created by Michael Adair on 14/07/2020.
//  Copyright © 2020 Michael Adair. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    var url: String!

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    @IBOutlet var button: UIButton!
    
    
    var pokemon: PokemonResult!


    func capitalise(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nameLabel.text = ""
        numberLabel.text = ""
        type1Label.text = ""
        type2Label.text = ""
        loadPokemon()
        
        
 
        
    }
    
    
    

    func loadPokemon() {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                return
            }

            do {
                let result = try JSONDecoder().decode(PokemonResult.self, from: data)
                DispatchQueue.main.async {
                    self.navigationItem.title = self.capitalise(text: result.name)
                    self.nameLabel.text = self.capitalise(text: result.name)
                    self.numberLabel.text = String(format: "#%03d", result.id)
                    self.pokemon = result
                    self.pokemon.caught = false
                    
                    
                    self.pokemon.caught ? self.button.setTitle("Caught!", for: .normal) : self.button.setTitle("Catch!", for: .normal)
                    
                    print(result)

                    for typeEntry in result.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = typeEntry.type.name
                        }
                        else if typeEntry.slot == 2 {
                            self.type2Label.text = typeEntry.type.name
                        }
                    }

                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
    
    
    
    // this is the button logic allowing us to mark a pokemon as caught
    
    @IBAction func toggleCatch() {
      // gotta catch 'em all!

        if !pokemon.caught {
            button.setTitle("Caught!", for: .normal)
            pokemon.caught.toggle()
        }
        else {
            button.setTitle("Catch!", for: .normal)
            pokemon.caught.toggle()
        }

    }
//
    
    
    
    
    
    
}

