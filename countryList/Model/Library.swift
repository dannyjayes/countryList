//
//  Library.swift
//  countryList
//
//  Created by Mador Til on 06/07/2021.
//

import Foundation
class Library{
    
    public static let librarySingleton = Library()
    private var countryDictionary : [String : Country]
    private var displayedCountryArray : [Country] = [] //Simple array of displayed countries for the tableview
    
    private init(){
        countryDictionary = [:]
        initList()
        generateArray()
    }
    
    private func initList(){
        //Initiate country dictionary from json file
        let tempList = jsonManager.jsonManagerSingleton.getJson()
        if(tempList.isEmpty){
            return
        }else{
            for country in tempList{
                countryDictionary[country["alpha3Code"] as! String] = Country(localName: country["nativeName"] as! String, internationalName: country["name"] as! String, borderingCountries: country["borders"] as! [String], Area: country["area"] as? Double ?? 0)
            }
        }
    }
    
    public func generateArray(){
        //Generate a country array from the country dictionary
        for key in countryDictionary.keys{
            displayedCountryArray.append(countryDictionary[key]!)
        }
    }
    public func generateNeighbourArray(for index: Int, sortBy: FilterType, onComplete : @escaping () -> Void){
        //Reset the country array to be a smaller array of neighbouring countries from selected country
        let country = displayedCountryArray[index]
        displayedCountryArray.removeAll()
        for neighbourCountry in country.getBorderingCountries(){
            displayedCountryArray.append(countryDictionary[neighbourCountry]!)
        }
        getArrayList()
        onComplete()
    }
    public func getArrayList(sortBy: FilterType) -> [Country]{
        //Get a sorted array list
        sortArray(type: sortBy)
        return displayedCountryArray
    }
    public func getArrayList() -> [Country]{
        //get an unsorted array list
        return displayedCountryArray
    }
    
    private func sortArray(type: FilterType){
        //Sort the array according to sorting type
        switch type {
            case .areaDescending:
                displayedCountryArray = displayedCountryArray.sorted(by: { (lhs, rhs) -> Bool in
                    lhs.getArea() > rhs.getArea()
                })
            case .areaAscending:
                displayedCountryArray = displayedCountryArray.sorted(by: { (lhs, rhs) -> Bool in
                    lhs.getArea() < rhs.getArea()
                })
            case .nameDescending:
                displayedCountryArray = displayedCountryArray.sorted(by: { (lhs, rhs) -> Bool in
                    lhs.getInternationalName() < rhs.getInternationalName()
                })
            case .nameAscending:
                displayedCountryArray = displayedCountryArray.sorted(by: { (lhs, rhs) -> Bool in
                    lhs.getInternationalName() > rhs.getInternationalName()
                })
        }
    }
}
