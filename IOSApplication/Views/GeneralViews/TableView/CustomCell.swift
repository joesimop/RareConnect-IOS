//
//  CustomCell.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/11/23.
//

import Foundation
import RxSwift
import RxCocoa

//protocol TableCell : UITableViewCell {
//    associatedtype Model where Model: Identifiable
//    static var ReuseIdentifier : String { get }
//    static func DisplayCell(_ row: Int, _ model: Model, _ cell: UITableViewCell) -> Void
//}
//
//class UberTableCell: UITableViewCell, TableCell {
//    typealias Model = UberDataTripsCompleted
//    static let ReuseIdentifier = "UberTableCell"
//    static func DisplayCell(_ row: Int, _ model: UberDataTripsCompleted, _ cell: UITableViewCell) {
//        cell.textLabel?.text = "\(model.driverId), \(model.tripsCompleted)"
//        cell.backgroundColor = row % 2 == 0 ? .systemMint : .white
//        
//    }
//}
