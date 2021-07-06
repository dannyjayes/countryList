//
//  JsonManager.swift
//  countryList
//
//  Created by Mador Til on 06/07/2021.
//

import Foundation
class jsonManager{
    
    public static let jsonManagerSingleton = jsonManager()
    
    private init(){
    }
    
    public func getJson() -> [Dictionary<String, AnyObject>]{
        //Return an array of Dictionaries from the json file.
        if let jsonPath = Bundle.main.path(forResource: "countryList", ofType: "json"){
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [Dictionary<String, AnyObject>]{
                    return jsonResult
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return []
    }
}
