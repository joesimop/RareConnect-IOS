//
//  SearchVm.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/28/24.
//

import Foundation
import SwiftUI
import RxSwift
import RxCocoa
import RxRelay

/* The need for a separate class here is for it to be created, then edit
   its query parameters as it persists. */
class SearchViewModel<T> where T : Decodable {
    
    
    private let request: SearchAPIRequest<[T]>                                 //Request that will be sent
    private let searchTextSubject = PublishSubject<SearchAPIRequest<[T]>>()     //Observable that emits currently typed text
    private let bag = DisposeBag()                                           //Bag for cleanup

    init(request: SearchAPIRequest<[T]>) {
        self.request = request
    }
    
    ///Exposed function for
    /// - Parameters:
    ///     - newQuery: The string that is being searched in the database
    /// - Returns: Void
    func search(newQuery: String) -> Void {
        self.request.updateSearch(newQuery: newQuery)
        self.searchTextSubject.onNext(self.request)
    }
    
    func bindTo( _ binding: Binding<[T]>) {
        self.searchTextSubject
            .debounce(.milliseconds(250), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { request in
                    api.sendSingleRequestRx(request.asSendableRequest())
                        .subscribe(
                            onSuccess: { result in
                                binding.wrappedValue = result
                            },
                            onFailure: { error in
                                print(error)
                            }
                        ).disposed(by: self.bag)
                }
            ).disposed(by: self.bag)
    }
}
