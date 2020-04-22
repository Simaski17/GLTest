//
//  AFWrapper.swift
//  GLTest
//
//  Created by Jimmy Hernandez on 22-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class AFWrapper: NSObject {
    class func requestGETURL(_ strURL: String, parameters: Parameters, success:@escaping ([String : Any]) -> Void, failure:@escaping (Error) -> Void) {
        AF.request(strURL, method: .post, parameters: parameters, encoding: URLEncoding(destination: .queryString)).responseJSON { (responseObject) -> Void in
//            print(responseObject)
            switch responseObject.result {
            case .success( _):
                success(responseObject.value! as! [String : Any])
            case .failure( _):
                let _ = responseObject.error!
            }
        }
    }
}
