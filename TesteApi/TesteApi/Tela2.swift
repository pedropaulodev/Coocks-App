//
//  Tela2.swift
//  TesteApi
//
//  Created by ALINE FERNANDA PONZANI on 05/09/24.
//

import SwiftUI

struct CardDrink: View {
    var image: String
    var name: String
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
                    .frame(width: 150, height: 150, alignment: .center)
            }
            Text(name)
        }
    }
}

struct Tela2: View {
    var tipo: String
    var name: String
    @State private var listDrisksFilter: [FilterDrink] = []
    @State private var listDrisks: [Drink] = []
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]
    var body: some View {
        VStack{
            Text(name.uppercased())
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading, 25.0)
            ScrollView{
                if tipo != "caracter" && tipo != "name"{
                    LazyVGrid(columns: adaptiveColumn, spacing: 8) {
                        ForEach(listDrisksFilter, id: \.idDrink){glass in
                            NavigationLink(destination: Tela3(idDrink: glass.idDrink)){
                                CardDrink(image: glass.strDrinkThumb, name: glass.strDrink)
                            }
                        }
                    }
                } else {
                    LazyVGrid(columns: adaptiveColumn, spacing: 8) {
                        ForEach(listDrisks, id: \.idDrink){glass in
                            NavigationLink(destination: Tela3(idDrink: glass.idDrink)){
                                CardDrink(image: glass.strDrinkThumb, name: glass.strDrink)
                            }
                        }
                    }
                }
            }
        }
        .task {
            await loadInitialCategories()
        }
    }
    private func loadInitialCategories() async {
        do {
            if tipo == "caracter" {
                listDrisks = try await getAllDrink(caracter: name)
            } else if tipo == "name"{
                listDrisks = try await getDrinkName(name: name)
            } else{
                listDrisksFilter = try await getDrinks(tipo: tipo, url: name)
            }
        } catch {
            print("Erro ao carregar dados: \(error)")
        }
    }
}

#Preview {
    Tela2(tipo: "name", name: "margarita")
}
