//
//  ViewModelUtilityFunctions.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/12/24.
//

import Foundation
import SwiftUI
import RxSwift


extension Single {
    
    //Makes looking at ViewModel API definition code a bit more digestible
    func CompletionHandler(action: @escaping (Element) -> Void, bag: DisposeBag) -> Void {
        return self.asObservable()
            .CompletionHandler(action: action)
            .disposed(by: bag)
    }
}


extension Observable {
    
    func CompletionHandler(action: @escaping (Element) -> Void) -> Disposable{
        return self.subscribe(
            ///On the next value coming into the observable, bind that to the parameter.
            onNext: { result in
                action(result)
            },
            onError: { error in
                print(error)
            }
        )
    }
    
    //Binds SwiftUI value to the response code
    func BindValue(binding: Binding<Element>) -> Disposable {
        return self
            .subscribe(
                ///On the next value coming into the observable, bind that to the parameter.
                onNext: { StatusResponse in
                    binding.wrappedValue = StatusResponse
                },
                onError: { error in
                    print(error)
                }
        )
    }
    
    //Binds SwiftUI value to the response code
    func BindViewResult(binding: Binding<ViewResult<Element>>) -> Disposable {
        return self
            .subscribe(
                ///On the next value coming into the observable, bind that to the parameter.
                onNext: { response in
                    binding.wrappedValue = ViewResult(object: response)
                },
                onError: { error in
                    print(error)
                }
        )
    }

}
//Allows for binding to APIReponseCodes
extension Observable where Element == APIResponseCode {
    
    //Binds SwiftUI value to the response code
    func BindValue(binding: Binding<APIResponseCode>) -> Disposable {
        return self
            .subscribe(
                ///On the next value coming into the observable, bind that to the parameter.
                onNext: { StatusResponse in
                    binding.wrappedValue = StatusResponse
                },
                onError: { error in
                    binding.wrappedValue = APIResponseCode.Error(HandleHttpError(error))
                }
        )
    }
    
    //Binds SwiftUI value to the response code
    func BindValueExecuteFunctionOnComplete(binding: Binding<APIResponseCode>, action: @escaping (APIResponseCode) -> Void) -> Disposable {
        return self
            .subscribe(
                ///On the next value coming into the observable, bind that to the parameter.
                onNext: { StatusResponse in
                    binding.wrappedValue = StatusResponse
                },
                onError: { error in
                    binding.wrappedValue = APIResponseCode.Error(HandleHttpError(error))
                },
                onCompleted: {
                    action(binding.wrappedValue)
                }
            )
    }
    
}
