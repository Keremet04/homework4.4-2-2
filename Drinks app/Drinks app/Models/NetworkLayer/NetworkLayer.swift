//
//  NetworkLayer.swift
//  Drinks app
//
//  Created by Керемет  on 23/2/23.
//

import Foundation

final class NetworkLayer {
    
static let shared = NetworkLayer()
    
private init() { }
    
enum Api {
case fetchingCocktail
case findCocktailName
case findCocktailID
        
var baseURL: URL {
            .init(
                string: "www.thecocktaildb.com"
            )!
        }
        
        var path: String {
            switch self {
            case .fetchingCocktail:
                return "/search.php"
            case .findCocktailName:
                return "/search.php"
            case .findCocktailID:
                return "/lookup.php"
            }
        }
        
        var components: URLComponents {
            var components = URLComponents()
           // components.scheme = "https"
            components.host = baseURL.absoluteString
            
            switch self {
            case .fetchingCocktail:
                components.path = "/api/json/v1/1\(Api.fetchingCocktail.path)"
            case .findCocktailName:
                components.path =  "/api/json/v1/1\(Api.findCocktailName.path)"
            case .findCocktailID:
                components.path =  "/api/json/v1/1\(Api.findCocktailID.path)"
            }
            
            return components
        }
    }
    
    func lookUpByLetter(by letter: String) async throws -> Cocktail {
        var components = Api.fetchingCocktail.components
        components.queryItems = [
            .init(name: "f", value: letter)
        ]
        guard let url = components.url else {
            print("URL is nil!")
            return Cocktail(drinks: [])
        }
        print(url)
        let (data, _) = try await URLSession.shared.data(from: url)
        return try await decodeData(data: data)
    }
    
    func fetchDataDrinks() async throws -> Cocktail {
        var coctailsArray = Cocktail(drinks: [])
        for letter in UnicodeScalar("a").value...UnicodeScalar("z").value {
            guard let currentLetter = UnicodeScalar(letter) else { break }
            print(currentLetter)
            let fetchedData = try await lookUpByLetter(by: String(currentLetter)).drinks ?? []
            coctailsArray.drinks?.append(contentsOf: fetchedData)
        }
        return coctailsArray
    }
    
    private func decodeData<T: Decodable>(data: Data) async throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}


