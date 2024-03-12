//
//  TableView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/11/23.
//

import SwiftUI
import RxSwift
import RxCocoa


// Create a SwiftUI view that wraps UITableView and conforms to RxTableViewDataSourceType and RxTableViewDelegateType
//struct RxSwiftTableView<Cell>: UIViewRepresentable where Cell : TableCell {
//    var items: Observable<[Cell.Model]> // Data source for the table view
//    private let disposeBag = DisposeBag()
//
//    func makeUIView(context: Context) -> UITableView {
//        let tableView = UITableView()
//        tableView.register(Cell.self, forCellReuseIdentifier: Cell.ReuseIdentifier)
//        return tableView
//    }
//
//    func updateUIView(_ uiView: UITableView, context: Context) {
//        // Bind data to the table view
//        items
//            .bind(to: uiView.rx.items(cellIdentifier: Cell.ReuseIdentifier, cellType: Cell.self))
//        { row, item, cell in Cell.DisplayCell(row, item, cell) }
//            .disposed(by: disposeBag)
//    }
//}

