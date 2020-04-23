//
//  DetailViewController.swift
//  GLTest
//
//  Created by Jimmy Hernandez on 22-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import UIKit
import SDWebImage
import JGProgressHUD

class DetailViewController: UIViewController {
    
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var tableViewMain: UITableView!
    
    private var viewModel = DetailViewModel()
    
    var arrSongsDetail = [Result]()
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        // Do any additional setup after loading the view.
        tableViewMain.isHidden = true
        albumName.text = arrSongsDetail[0].collectionName
        artistName.text = arrSongsDetail[0].artistName
        albumImage.sd_setImage(with: URL(string: arrSongsDetail[0].artworkUrl100))
        viewModel.getListSongsAlbum(term: "\(arrSongsDetail[0].artistName) + \(arrSongsDetail[0].collectionName)")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hud.textLabel.text = "Cargando..."
        hud.show(in: self.view)
        hud.position = .bottomCenter
    }
    
    
}

extension DetailViewController: DetailViewModelDelegate {
    func reloadData() {
        self.tableViewMain.isHidden = false
        self.tableViewMain.reloadData()
        self.hud.dismiss()
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfitems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailAlbumTableViewCell
        if (viewModel.arrSongsAlbumDetail.count > 0) {
            cell.setup(event: viewModel.arrSongsAlbumDetail, index: indexPath)
        }
        return cell
    }
    
    
}
