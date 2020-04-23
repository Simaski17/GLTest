//
//  MainViewModel.swift
//  GLTest
//
//  Created by Jimmy Hernandez on 22-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate {
    func reloadData()
}


class MainViewModel {
    
    var delegate: MainViewModelDelegate?
    var arrSongs = [Result]()
    
    var numberOfitems: Int {
        return arrSongs.count
    }
    
    func getListSongs(term: String, offset: Int){
        NetworkManager.shared.getListSongs(term: term, offset: offset).then({
            self.arrSongs = $0
            self.delegate?.reloadData()
        }).catch({
            print($0)
        })
    }
    
    
}
