//
//  ListViewController.swift
//  MachineTest
//
//  Created by Nilesh Gadhe on 07/04/21.
//  Copyright © 2021 Innofied. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    private var listViewModel = ListViewModel()
    var listApiDataArray = [ListApiData]()
    
    var refreshControl = UIRefreshControl()
    
    var pageCount = 1
    var totalNumberOfRecords = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDetegates()
        setUpUI()
        infiniteScrollFunction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CustumLoader.instance.showLoader()
        callListApi(pageCount: pageCount)
    }
    
    func setDetegates(){
        listViewModel.delegate = self
        
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    func setUpUI(){
        
        listTableView.estimatedRowHeight = 100
        listTableView.rowHeight = UITableView.automaticDimension
        
        listTableView.register(UINib(nibName: ConstantStrings.listCell, bundle: nil), forCellReuseIdentifier: ConstantStrings.listCell)
        
        refreshControl.attributedTitle = NSAttributedString(string: ConstantStrings.pullToRefresh)
        refreshControl.addTarget(self, action: #selector(self.refreshTable(_:)), for: .valueChanged)
        listTableView.addSubview(refreshControl)
    }
    
    @objc func refreshTable(_ sender: AnyObject) {
        
        pageCount = 1
        listApiDataArray.removeAll()
        callListApi(pageCount: pageCount)
        refreshControl.endRefreshing()
    }
    
    func infiniteScrollFunction(){
        
        self.listTableView.addInfiniteScroll { (table) in
            if self.totalNumberOfRecords != self.listApiDataArray.count{
                self.callListApi(pageCount: self.pageCount)
            }
            self.listTableView.finishInfiniteScroll()
        }
    }
    
    func callListApi(pageCount : Int){
        listViewModel.apiCallList(listApiString: "https://reqres.in/api/users?page=\(pageCount)&per_page=8")
    }
    
    
    func newFunc(){
        //added new function in home
    }
}

extension ListViewController : ListViewModelDelegate{
    
    func didReceiveListApiResponse(listApiResponse: ListApiResponse) {
        
        CustumLoader.instance.hideLoader()
        
        if listApiResponse.data!.count != 0{
            pageCount = pageCount + 1
            totalNumberOfRecords = listApiResponse.totalPages!
            self.listApiDataArray =  self.listApiDataArray + listApiResponse.data!
            self.listTableView.reloadData()
        }
    }
}

extension ListViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listApiDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantStrings.listCell, for: indexPath) as! ListTableViewCell
        
        cell.lblUserName.text = "\(listApiDataArray[indexPath.row].firstName!) \(listApiDataArray[indexPath.row].lastName!)"
        cell.lblUserEmail.text = listApiDataArray[indexPath.row].email!
        cell.lblUserId.text = "\(ConstantStrings.userId)\(listApiDataArray[indexPath.row].id!)"
        
        let imageUrlString = listApiDataArray[indexPath.row].avatar!
        let imageUrl = URL(string: imageUrlString)
        
        cell.imgViewUser.image = #imageLiteral(resourceName: "icProfilePlaceholder")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageUrl!)
            DispatchQueue.main.async {
                cell.imgViewUser.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
}
