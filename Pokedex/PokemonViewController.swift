//
//  pokemonViewController.swift
//  Pokedex
//
//  Created by Michael Adair on 14/07/2020.
//  Copyright © 2020 Michael Adair. All rights reserved.
//

import UIKit


var caughtPokemon = CaughtPokemon.init(caught: [ : ] )
var userData = UserDefaults.standard

class PokemonViewController: UIViewController {
    var url: String!
    
    var infoUrl: String!

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    @IBOutlet var pokemonBio: UITextView!
    @IBOutlet var button: UIButton!
    @IBOutlet var pokemonImage: UIImageView!
    

    func capitalise(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nameLabel.text = ""
        numberLabel.text = ""
        pokemonBio.text = ""
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
                    self.infoUrl = "https://pokeapi.co/api/v2/pokemon-species/" + String(result.id) + "/"
                    
                    self.loadPokemonInfo()
                    
                    
                    let imageURL = URL(string: result.sprites.front_default)
                    
                    let pokemonData = try? Data(contentsOf: imageURL!)
                     
                    self.pokemonImage.image = UIImage(data: pokemonData!)


                    for typeEntry in result.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = self.capitalise(text: typeEntry.type.name)
                        }
                        else if typeEntry.slot == 2 {
                            self.type2Label.text = self.capitalise(text: typeEntry.type.name)
                        }
                    }
                    
                    // checks the UserDefaults class for any previous true or false values for this pokemon. Allowing us to maintain state when the app is restarted
                    
                    if userData.bool(forKey: self.nameLabel.text!) == true {
                                    
                                    caughtPokemon.caught[self.nameLabel.text!] = true
                                    
                                }
                    
                    // sets the default state for the button when the page renders
                    if caughtPokemon.caught[self.nameLabel.text!] == false || caughtPokemon.caught[self.nameLabel.text!] == nil  {
                            
                        self.button.setTitle("Catch", for: .normal)
                           
                       }
                    else if caughtPokemon.caught[self.nameLabel.text!] == true {
                            
                        self.button.setTitle("Release", for: .normal)

                       }
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
    
    
    
    func loadPokemonInfo() {
           URLSession.shared.dataTask(with: URL(string: infoUrl)!) { (data, response, error) in
               guard let data = data else {
                   return
               }

               do { let result = try JSONDecoder().decode(PokemonInfo.self, from: data)
                 DispatchQueue.main.async {
                
                    self.pokemonBio.text = result.flavor_text_entries[0].flavor_text
                    
                    
                    print(self.pokemonBio.text)
                
                }
                
            }
            catch let error {
                           print(error)
                       }
                   }.resume()
            
    }
    
    
    
    
    
    
    
    
    // this is the logic that toggles between catching and releasing on button click
    @IBAction func toggleCatch() {
        
        print(userData)

        if caughtPokemon.caught[nameLabel.text!] == false || caughtPokemon.caught[nameLabel.text!] == nil {
                
                button.setTitle("Release", for: .normal)
                caughtPokemon.caught[nameLabel.text!] = true
                userData.set(true, forKey: nameLabel.text!)
                
            }
            
            
            else{
                button.setTitle("Catch", for: .normal)
                caughtPokemon.caught[nameLabel.text!] = false
                userData.set(false, forKey: nameLabel.text!)
            }

    }
    
}

