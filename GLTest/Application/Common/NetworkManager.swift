//
//  NetworkManager.swift
//  GLTest
//
//  Created by Jimmy Hernandez on 22-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import Foundation
import Promise
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    //MARK: - Singleton
    class var shared: NetworkManager{
        struct Static {
            static let instance = NetworkManager()
        }
        return Static.instance
    }
    
    var arrSongs = [Result]()
    
    public func getListSongs(term: String)->Promise<[Result]> {
        return Promise<[Result]>(work: {
            fullfill,reject in
            
            
            let parameters: Parameters = [
            "term": term
            ]
            
            AFWrapper.requestGETURL("https://itunes.apple.com/search?mediaType=music&limit=20", parameters: parameters, success: { (responseObject) in
                for aResult in responseObject["results"] as! [Any] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: aResult, options: .prettyPrinted)
                        let reqJSONStr = String(data: jsonData, encoding: .utf8)
                        let data = reqJSONStr?.data(using: .utf8)
                        let jsonDecoder = JSONDecoder()
                        let aResultSong = try jsonDecoder.decode(Result.self, from: data!)
                        self.arrSongs.append(aResultSong)
                    }
                    catch {
                        reject(error)
                        return
                    }
                }
                fullfill(self.arrSongs)
                return
            }) { (error) in
                print(error.localizedDescription)
                reject(error)
                return
            }
            
        })
    }
    
    public func getListSongsAlbum(term: String)->Promise<[Result]> {
        return Promise<[Result]>(work: {
            fullfill,reject in
            
            
            let parameters: Parameters = [
            "term": term
            ]
            
            AFWrapper.requestGETURL("https://itunes.apple.com/search?entity=song", parameters: parameters, success: { (responseObject) in
                for aResult in responseObject["results"] as! [Any] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: aResult, options: .prettyPrinted)
                        let reqJSONStr = String(data: jsonData, encoding: .utf8)
                        let data = reqJSONStr?.data(using: .utf8)
                        let jsonDecoder = JSONDecoder()
                        let aResultSong = try jsonDecoder.decode(Result.self, from: data!)
                        self.arrSongs.append(aResultSong)
                    }
                    catch {
                        reject(error)
                        return
                    }
                }
                fullfill(self.arrSongs)
                return
            }) { (error) in
                print(error.localizedDescription)
                reject(error)
                return
            }
            
        })
    }
    
    
    
}
