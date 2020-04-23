//
//  ViewController.swift
//  GLTest
//
//  Created by Jimmy Hernandez on 22-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import UIKit
import JGProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewMain: UITableView!
    
    private var viewModel = MainViewModel()
    let hud = JGProgressHUD(style: .dark)
    private var searchTerm = ""
    private var offset = 0
    private var nextItem = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        tableViewMain.isHidden = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            let vc = segue.destination as! DetailViewController
            if let item = sender as? Result {
                vc.arrSongsDetail.append(item)
            }
        }
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItunesTableViewCell
        if (viewModel.arrSongs.count > 0) {
            cell.setup(event: viewModel.arrSongs, index: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueDetail", sender: viewModel.arrSongs[indexPath.row])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == tableViewMain{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if nextItem {
                    offset = offset + 20
                    viewModel.getListSongs(term: self.searchTerm, offset: offset, next: false)
                    nextItem = false
                    hud.textLabel.text = "Cargando..."
                    hud.show(in: self.view)
                    hud.position = .bottomCenter
                }
            }
        }
    }
    
}

extension ViewController: MainViewModelDelegate {
    func reloadData() {
        self.tableViewMain.isHidden = false
        self.tableViewMain.reloadData()
        self.hud.dismiss()
        nextItem = true
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text! != self.searchTerm{
            self.searchTerm = searchBar.text!
            offset = 0
            viewModel.getListSongs(term: searchBar.text!, offset: offset, next: true)
        } else {
            viewModel.getListSongs(term: searchBar.text!, offset: offset, next: false)
        }
        self.view.endEditing(true)
        
        hud.textLabel.text = "Cargando..."
        hud.show(in: self.view)
        hud.position = .bottomCenter
        
    }
    
}

