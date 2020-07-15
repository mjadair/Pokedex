//
//  Pokemon.swift
//  Pokedex
//
//  Created by Michael Adair on 13/07/2020.
//  Copyright © 2020 Michael Adair. All rights reserved.
//



// THIS IS OUR MODEL FILE
import Foundation

struct PokemonListResults: Codable {
    let results: [PokemonListResult]
}

struct PokemonListResult: Codable {
    let name: String
    let url: String
}

struct PokemonResult: Codable {
    let id: Int
    let name: String
    let types: [PokemonTypeEntry]
    let sprites: Images
}

struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}



struct Images: Codable {
 let front_default: String
}


struct CaughtPokemon {
 
 var caught = [String: Bool]()

 }




