//
//  MainViewModel.swift
//  Drinks app
//
//  Created by Керемет  on 23/2/23.
//

import Foundation

class CoctailsMenuViewModel {
    
    let networkManager = NetworkLayer.shared
    
    var coctailsArray = [Drinks]()
    
    func fetchCoctailsData() async throws -> [Drinks] {
        coctailsArray = try await networkManager.fetchDataDrinks().drinks!
        print(coctailsArray)
        return coctailsArray
        
    }
    
    func returnCoctail(at index: Int) -> Drinks {
        return coctailsArray[index]
    }
    
    func returnCoctailsCount() -> Int {
        return coctailsArray.count
    }
    
}
