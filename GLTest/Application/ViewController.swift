//
//  ViewController.swift
//  GLTest
//
//  Created by Jimmy Hernandez on 22-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewMain: UITableView!
    
     var arrSongs = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NetworkManager.shared.getListSongs().then({
                print("RESULTADO")
                print($0)
                self.arrSongs = $0
                self.tableViewMain.reloadData()
                }).catch({
                    print($0)
                })
            
        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItunesTableViewCell
        if (self.arrSongs.count > 0) {
            cell.setup(event: self.arrSongs, index: indexPath)
        }
        return cell
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("TEXTO BUSQUEDA")
        print(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("TEXTO BUSCAR")
        print(searchBar.text!)
    }
    
}

