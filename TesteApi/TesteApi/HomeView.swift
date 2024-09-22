//
//  ContentView.swift
//  TesteApi
//
//  Created by ALINE FERNANDA PONZANI on 05/09/24.
//

import SwiftUI

struct CardFilter: View {
    var urlImage: String? = nil
    var image: String?
    var name: String
    var body: some View {
        VStack{
            if urlImage == nil{
                Image(image ?? "")
            } else{
                AsyncImage(url: URL(string: "https://www.thecocktaildb.com/images/ingredients/\(name).png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
            }
            Text(name)
        }
    }
}

struct HomeView: View {
    @State private var glasses: [Categorie] = []
    @State private var categories: [Categorie] = []
    @State private var ingredient: [Categorie] = []
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading) {
                    Text("Glasses")
                        .foregroundColor(Color(Color.black))
                        .fontWeight(.bold)
                        .font(.system(size: 24, design: .default))
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 20) {
                            ForEach(glasses, id: \.strGlass){glass in
                                NavigationLink(destination: Tela2(tipo: "g", name: glass.strGlass ?? "")){
                                    CardFilter(image: glass.strGlass ?? "", name: glass.strGlass ?? "")
                                }
                            }
                        }
                    }
                }.frame(height: 180)
                    .padding()
                VStack(alignment: .leading) {
                    Text("Categories")
                        .foregroundColor(Color(Color.black))
                        .fontWeight(.bold)
                        .font(.system(size: 24, design: .default))
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 20) {
                            ForEach(categories, id: \.strCategory){categorie in
                                NavigationLink(destination: Tela2(tipo: "c", name: categorie.strCategory ?? "")){
                                    let sanitizedCategory = categorie.strCategory ?? ""
                                    CardFilter(image:sanitizedCategory.replacingOccurrences(of: "/", with: ""), name: categorie.strCategory ?? "")
                                }
                            }
                        }
                    }
                }.frame(height: 180)
                    .padding()
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .foregroundColor(Color(Color.black))
                        .fontWeight(.bold)
                        .font(.system(size: 24, design: .default))
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 20) {
                            ForEach(ingredient, id: \.strIngredient1){ingredient in
                                NavigationLink(destination: Tela2(tipo: "i", name: ingredient.strIngredient1 ?? "")){
                                    CardFilter(urlImage: ingredient.strIngredient1 ?? "", name: ingredient.strIngredient1 ?? "")
                                }
                            }
                        }
                    }
                }.frame(height: 180)
                    .padding()
            }
            .task {
                await loadInitialCategories()
            }
        }
    }
    private func loadInitialCategories() async {
        do {
            glasses = try await getCategorie(tipo: "g")
            categories = try await getCategorie(tipo: "c")
            ingredient = try await getCategorie(tipo: "i")
        } catch {
            print("Erro ao carregar dados!")
        }
    }
}



#Preview {
    HomeView()
}
