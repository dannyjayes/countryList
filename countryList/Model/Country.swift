//
//  Country.swift
//  countryList
//
//  Created by Mador Til on 06/07/2021.
//

import Foundation
struct Country{
    //Simple data class to display class
    private var localName : String
    private var internationalName : String
    private var borderingCountries : [String]
    private var Area : Double
    
    public init(localName : String, internationalName : String, borderingCountries : [String], Area : Double){
        self.localName = localName
        self.internationalName = internationalName
        self.borderingCountries = borderingCountries
        self.Area = Area
    }

    public func getLocalName() -> String{
        return localName
    }
    public func getInternationalName() -> String{
        return internationalName
    }
    public func getBorderingCountries() -> [String]{
        return borderingCountries
    }
    public func getArea() -> Double{
        return Area
    }
}
