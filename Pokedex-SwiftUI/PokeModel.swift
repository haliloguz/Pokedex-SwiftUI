//
//  PokeModel.swift
//  Pokedex-SwiftUI
//
//  Created by Halil Oğuz on 7.06.2023.
//

import SwiftUI

struct Poke: Identifiable, Decodable {
    
    var pokeID = UUID()
    
    let id: Int
    let name: String
    let imageURL: String
    let type: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case imageURL = "imageUrl"
        case type
        case description
    }
}

enum FetchError: Error {
    case badURL
    case badResponse
    case badData
}

class PokeModel {
    func getPokemon() async throws -> [Poke] {
        guard let url = URL(string: "https://pokedex-bb36f.firebaseio.com/pokemon.json") else {
            throw FetchError.badURL }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let data = data.removeNullsFrom(string: "null") else { throw FetchError.badURL}
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badData}
        
        let maybePokemonData = try JSONDecoder().decode([Poke].self, from: data)
        return maybePokemonData
    }
}

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parseDataString?.data(using: .utf8) else {return nil}
        
        return data
    }
}
