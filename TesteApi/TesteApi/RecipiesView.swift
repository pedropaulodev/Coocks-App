//
//  Tela3.swift
//  TesteApi
//
//  Created by ALINE FERNANDA PONZANI on 05/09/24.
//

import SwiftUI

struct Tela3: View {
    var idDrink: String
    @State private var listDrisks: [Drink] = []
    var body: some View {
        ScrollView{
            ForEach(listDrisks, id: \.idDrink){drink in
                VStack(spacing: 16.0){
                    AsyncImage(url: URL(string:drink.strDrinkThumb)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFill()
                    .frame(width: 340, height: 330)
                    .cornerRadius(/*@START_MENU_TOKEN@*/40.0/*@END_MENU_TOKEN@*/)
                    
                    Text(drink.strDrink)
                        .font(.title)
                        .foregroundColor(Color.black)
                    
                    //lista de ingredientes
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(alignment: .center, spacing: 20.0){
                            ForEach(drink.getIngredientes(), id: \.1) {
                                (medida, ingredient) in
                                CardFilter(urlImage: ingredient, name: ingredient)
                            }
                        }
                        .frame(height: 130)
                    }
                    HStack(alignment: .top, spacing: 12.0) {
                        VStack {
                            Text("Glass")
                                .font(.title2)
                                .foregroundColor(Color.black)
                            CardFilter(image: drink.strGlass ?? "", name: drink.strGlass ?? "")
//                            FilterCards(name: drink.strGlass ?? "",tipo: "g")
//                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding()
                        .background(Color.white)
                        
                        VStack(alignment: .leading) {
                            Text("Instructions")
                                .font(.title2)
                                .foregroundColor(Color(Color.black))
                            Text(drink.strInstructions)
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding()
                        .background(Color.white)
                    }
                    .padding(.horizontal, 17.0)
                }
            }
            .scrollContentBackground(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
        }
            .padding()
            .task {
                await loadInitialCategories()
            }
    }
    private func loadInitialCategories() async {
        do {
            listDrisks = try await getDrinkId(id: idDrink)
        } catch {
            print("Erro ao carregar dados: \(error)")
        }
    }
}

#Preview {
    Tela3(idDrink: "11007")
}
