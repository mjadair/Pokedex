//
//  Pokemon.swift
//  Pokedex
//
//  Created by Michael Adair on 13/07/2020.
//  Copyright © 2020 Michael Adair. All rights reserved.
//



// THIS IS OUR MODEL FILE
import Foundation


struct PokemonList: Codable {
    let results: [Pokemon]
}


struct Pokemon: Codable {
    
    let name: String
//    let number: Int
    let url: String
}


struct PokemonData: Codable {
    
    let id: Int
    let types: [PokemonTypeEntry]
}


struct PokemonType: Codable {
    let name: String
    let url: String
}


struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}



