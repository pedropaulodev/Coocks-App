//
//  Structs.swift
//  TesteApi
//
//  Created by ALINE FERNANDA PONZANI on 05/09/24.
//

import Foundation

struct CategorieResponse: Codable {
    let drinks: [Categorie]
}

struct Categorie: Codable {
    let strCategory: String?
    let strGlass: String?
    let strIngredient1: String?
}

func getCategorie(tipo: String) async throws -> [Categorie] {
    guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?\(tipo)=list") else {
        throw GHError.invalidURL
    }
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do{
        let decoder = JSONDecoder()
        let response = try decoder.decode(CategorieResponse.self, from: data)
        return response.drinks
    }
    catch{
        throw GHError.invalidData
    }
}

struct FilterDrinkResponse: Codable {
    let drinks: [FilterDrink]
}

struct FilterDrink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}

func getDrinks(tipo: String, url: String) async throws -> [FilterDrink] {
    guard let url2 = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?\(tipo)=\(url)") else {
        throw GHError.invalidURL
    }
    let (data, response) = try await URLSession.shared.data(from: url2)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do{
        let decoder = JSONDecoder()
        let response = try decoder.decode(FilterDrinkResponse.self, from: data)
        return response.drinks
    }
    catch{
        throw GHError.invalidData
    }
}

struct DrinkResponse: Codable {
    let drinks: [Drink]
}

// Modelo simplificado para o drink
struct Drink: Codable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String
    let strGlass: String?
    let strInstructions: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    
    
    
    // Método que organiza os ingredientes e medidas
    func getIngredientes() -> [(String, String)] {
        var ingredientes: [(String, String)] = []

        let allIngredients = [
            (strIngredient1, strMeasure1),
            (strIngredient2, strMeasure2),
            (strIngredient3, strMeasure3),
            (strIngredient4, strMeasure4),
            (strIngredient5, strMeasure5),
            (strIngredient6, strMeasure6),
            (strIngredient7, strMeasure7),
            (strIngredient8, strMeasure8),
            (strIngredient9, strMeasure9),
            (strIngredient10, strMeasure10),
            (strIngredient11, strMeasure11),
            (strIngredient12, strMeasure12),
            (strIngredient13, strMeasure13),
            (strIngredient14, strMeasure14),
            (strIngredient15, strMeasure15)
        ]

        for (ingredient, measure) in allIngredients {
            if let ingredient = ingredient, !ingredient.isEmpty {
                if let measure = measure, !measure.isEmpty {
                    ingredientes.append(contentsOf: [(measure, ingredient)])
                } else {
                    ingredientes.append(contentsOf: [("to taste", ingredient)])
                }
            }
        }
        return ingredientes
    }
}

func getAllDrink(caracter: String) async throws -> [Drink] {
    guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=\(caracter)") else {
        throw GHError.invalidURL
    }

    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        let drinkResponse = try decoder.decode(DrinkResponse.self, from: data)
        return drinkResponse.drinks
    } catch {
        throw GHError.invalidData
    }
}

func getDrinkName(name: String) async throws -> [Drink] {
    guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(name)") else {
        throw GHError.invalidURL
    }

    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        let drinkResponse = try decoder.decode(DrinkResponse.self, from: data)
        return drinkResponse.drinks
    } catch {
        throw GHError.invalidData
    }
}

func getDrinkId(id: String) async throws -> [Drink] {
    guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)") else {
        throw GHError.invalidURL
    }

    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        let drinkResponse = try decoder.decode(DrinkResponse.self, from: data)
        return drinkResponse.drinks
    } catch {
        throw GHError.invalidData
    }
}








enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case networkError
}
