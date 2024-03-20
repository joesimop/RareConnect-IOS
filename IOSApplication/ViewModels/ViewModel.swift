//
//  ViewModel.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 12/11/23.
//

import Foundation
import SwiftUI
import RxSwift
import RxCocoa

///Protocol to ensure a ViewModel has basic functionality.
protocol ViewModel : ObservableObject {
    var community_id: Int { get }
    var profile_id: Int { get }
    func Refresh() -> Void
    func OnViewOpen() -> Void
}


///Enum that defines possible states of API loaded data.
enum ViewResultState{
    case object
    case loading
    case code(APIResponseCode)
}

///Struct that holds API call state and its associated data that can be used in a View.
struct ViewResult<T> : Equatable {
    static func == (lhs: ViewResult<T>, rhs: ViewResult<T>) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private var identifier = UUID()
    var data: T?
    var state: ViewResultState = .loading
    var defaultValue: T?
    
    init(){
        self.state = .loading
        self.data = nil
    }
    
    init(defaultValue: T) {
        self.state = .loading
        self.data = defaultValue
        self.defaultValue = defaultValue
    }
    
    init(object: T){
        self.state = .object
        self.data = object
    }
    
    init(errorCode: APIResponseCode){
        self.state = .code(errorCode)
        self.data = nil
    }
    
    static func Loading() -> ViewResult<T>{
        return ViewResult()
    }
    
    
    ///Sets object and state variables if the APIResponse was successful.
    ///If it was unsuccessful, it sets error code and sets the ViewResult State to code.
    mutating func SetData(_ result: APIResult<T>) -> Void {
        switch result {
            case .success(let data):
                self.data = data.data
                self.state = .object
                
            case .failure(let error):
                self.state = .code(APIResponseCode.Error(error))
        }
    }
    
    ///If possible, sets data to default value and set its state to .loading
    mutating func Refresh() -> Void {
        if let defaultData = self.defaultValue {
            self.data = defaultData
        }
        self.state = .loading
    }
    
}
