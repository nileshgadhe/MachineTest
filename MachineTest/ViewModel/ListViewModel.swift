//
//  ListViewModel.swift
//  MachineTest
//
//  Created by Nilesh Gadhe on 07/04/21.
//  Copyright © 2021 Innofied. All rights reserved.
//

import Foundation


protocol ListViewModelDelegate {
    func didReceiveListApiResponse(listApiResponse : ListApiResponse)
}

struct ListViewModel {

    var delegate : ListViewModelDelegate?
    
    func apiCallList(listApiString: String){
        
        let listResource = ListResource()
        
        listResource.loginUser(listUrlString: listApiString) { (listApiResponse) in
            
            DispatchQueue.main.async {
                self.delegate?.didReceiveListApiResponse(listApiResponse: listApiResponse)
            }
        }
    }
}
