//
//  CountryTableViewCell.swift
//  countryList
//
//  Created by Mador Til on 06/07/2021.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    //Country cell class, to display international name and local name
    @IBOutlet weak var internationalName: UILabel!
    @IBOutlet weak var localName: UILabel!
    public var cellCountry : Country!{
        didSet{
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func updateUI(){
        //Uptade the labels
        internationalName.text = cellCountry.getInternationalName()
        localName.text = cellCountry.getLocalName()
    }

}
