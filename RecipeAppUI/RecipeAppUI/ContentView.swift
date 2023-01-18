//
//  ContentView.swift
//  RecipeAppUI
//
//  Created by Jorge Menco on 1/16/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var recipes: [String] = []
    var body: some View {

        NavigationStack {
                   Text("Searching for \(searchText)")
                       .navigationTitle("Recipe List")
            List {
                ForEach(recipes, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }.navigationTitle("Recipes")
            
        }.searchable(text: $searchText)
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
