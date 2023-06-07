//
//  ContentView.swift
//  Pokedex-SwiftUI
//
//  Created by Halil Oğuz on 7.06.2023.
//

import SwiftUI

struct ContentView: View {
    var pokeModel = PokeModel()
    @State private var pokemons = [Poke]()
    
    var body: some View {
        NavigationView {
            List(pokemons) { poke in
                
                Text(poke.name)
                Text(poke.type)

            }
        }
        .onAppear {
            async {
                pokemons = try! await pokeModel.getPokemon()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
