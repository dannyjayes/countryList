//
//  CountryTableViewController.swift
//  countryList
//
//  Created by Mador Til on 06/07/2021.
//

import UIKit

class CountryTableViewController: UITableViewController {

    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var topToBottomButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    private var filterType = FilterType.nameDescending{
        didSet{
            reloadView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameButton.isSelected = true
        nameButton.isEnabled = false
        topToBottomButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    private func selectCountry(index: Int){
        //Handle selecting a country
        backButton.isHidden = false
        Library.librarySingleton.generateNeighbourArray(for: index, sortBy: filterType, onComplete: reloadView)
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        //Clicking the back button, simply go back to first screen
        Library.librarySingleton.generateArray()
        reloadView()
        backButton.isHidden = true
    }
    @IBAction func onClickName(_ sender: Any) {
        //Sort by name
        nameButton.isSelected = true
        nameButton.isEnabled = false
        areaButton.isSelected = false
        areaButton.isEnabled = true
        if(filterType.rawValue > 1){
            filterType = .nameAscending
        }else{
            filterType = .nameDescending
        }
    }
    @IBAction func onClickArea(_ sender: Any) {
        //Sort by area
        nameButton.isSelected = false
        nameButton.isEnabled = true
        areaButton.isSelected = true
        areaButton.isEnabled = false
        if(filterType.rawValue > 1){
            filterType = .areaAscending
        }else{
            filterType = .areaDescending
        }    }
    @IBAction func onClickTopBottom(_ sender: Any) {
        //Switch between ascending or descending order
        switch filterType {
        case .areaAscending:
            topToBottomButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            filterType = .areaDescending
        case .areaDescending:
            topToBottomButton.imageView?.transform = CGAffineTransform(rotationAngle: 0)
            filterType = .areaAscending
        case .nameAscending:
            topToBottomButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            filterType = .nameDescending
        case .nameDescending:
            topToBottomButton.imageView?.transform = CGAffineTransform(rotationAngle: 0)
            filterType = .nameAscending
        }
        
    }
    
    
    private func reloadView(){
        //Refresh table view to show updated values
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Library.librarySingleton.getArrayList().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is CountryTableViewCell{
            let cell = cell as! CountryTableViewCell
            cell.cellCountry = Library.librarySingleton.getArrayList(sortBy: filterType)[indexPath.row]
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCountry(index: indexPath.row)
    }

}
