//
//  TableTableViewController.swift
//  TuTuTest
//
//  Created by Владимир Тимофеев on 13.11.2021.
//

import UIKit

class TableViewController: UITableViewController {

    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://www.hackingwithswift.com/samples/petitions-1.json"),
           let data = try? Data(contentsOf: url) {
               parse(from: data)
               saveOrLoad(isConnected: true, data: data)
           } else {
               saveOrLoad(isConnected: false, data: nil)
        }
        
    }
    
    // MARK: - Transform json to Petition structure
    func parse(from json: Data) {
        let jsonDecoder = JSONDecoder()
        
        if let jsonPetitions = try? jsonDecoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    // MARK: - Save, load or show error message
    func saveOrLoad(isConnected: Bool, data: Data?) {
        let defaults = UserDefaults.standard
        
        if isConnected {
            defaults.set(data, forKey: "Petitions")
        } else {
            if let localData = defaults.object(forKey: "Petitions") as? Data {
                parse(from: localData)
            } else {
                let ac = UIAlertController(title: "Error", message: "Failed to load data. Check your internet connection.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(ac, animated: true)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = petitions[indexPath.row].title
        cell.contentConfiguration = content

        return cell
    }
    
    // MARK: - Petition transmission to DetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let petition = petitions[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.petition = petition
        }
    }
    

}
