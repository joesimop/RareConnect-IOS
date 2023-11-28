//
//  UberTable.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 11/4/23.
//

import SwiftUI
import RxSwift
import RxCocoa

class ct: UITableViewCell{
    @IBOutlet var name : UILabel?
    @IBOutlet var plantDescription : UILabel?
}

class UberTableView: UITableViewController {
    
    
    let disposeBag = DisposeBag()
    var VM : UberVM = UberVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        loadTable()
    }
    
    func loadTable(){
        self.VM.GetTripsCompleted().asObservable()
            .bind(to: tableView.rx
                .items(cellIdentifier: "Cell")) { row, model, cell in
                cell.textLabel?.text = "\(model.driverId), \(model.tripsCompleted)"
        }.disposed(by: disposeBag)
    }
}

#Preview {
    UberTableView()
}
