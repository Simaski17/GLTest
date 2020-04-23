//
//  DetailViewModel.swift
//  GLTest
//
//  Created by Jimmy Hernandez on 22-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import Foundation
 
protocol DetailViewModelDelegate {
    func reloadData()
}

class DetailViewModel {
    
   var delegate: DetailViewModelDelegate?
   var arrSongsAlbumDetail = [Result]()
    
    
    var numberOfitems: Int {
        return arrSongsAlbumDetail.count
    }
    
    func getListSongsAlbum(term: String){
        NetworkManager.shared.getListSongsAlbum(term: term).then({
            print($0)
            print(term)
            self.arrSongsAlbumDetail = $0
            self.delegate?.reloadData()
        }).catch({
            print($0)
        })
    }
    
}
