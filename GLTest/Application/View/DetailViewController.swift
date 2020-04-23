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
    
    var arrSongsDetail = [Result]()
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewMain.isHidden = true
        albumName.text = arrSongsDetail[0].collectionName
        artistName.text = arrSongsDetail[0].artistName
        albumImage.sd_setImage(with: URL(string: arrSongsDetail[0].artworkUrl100))
        
        
        NetworkManager.shared.getListSongsAlbum(term: "\(arrSongsDetail[0].artistName) \(arrSongsDetail[0].collectionName)").then({
            self.arrSongsDetail = $0
            self.tableViewMain.isHidden = false
            self.tableViewMain.reloadData()
            self.hud.dismiss()
        }).catch({
            print($0)
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hud.textLabel.text = "Cargando..."
        hud.show(in: self.view)
        hud.position = .bottomCenter
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSongsDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailAlbumTableViewCell
        if (self.arrSongsDetail.count > 0) {
            cell.setup(event: self.arrSongsDetail, index: indexPath)
        }
        return cell
    }
    
    
}
