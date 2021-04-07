//
//  ListResource.swift
//  MachineTest
//
//  Created by Nilesh Gadhe on 07/04/21.
//  Copyright © 2021 Innofied. All rights reserved.
//

import Foundation

struct ListResource {
    
    func loginUser(listUrlString: String, completionHandler: @escaping(_ result: ListApiResponse) -> Void){
        
        let listUrl = URL(string: listUrlString)
        
        let httpUtility = HttpUtility()
        
        httpUtility.getApiData(requestUrl: listUrl!, resultType: ListApiResponse.self) { (listApiResponse) in
        
            _ = completionHandler(listApiResponse!)
        }
    }
}
