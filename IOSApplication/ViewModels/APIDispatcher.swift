//
//  ViewModel2.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/2/24.
//

import Foundation
import SwiftUI
import RxSwift

///Type alias for an APIResult
typealias APIResult<T> = Result<APIResultWithRequestIdentifier<T>, APIResponseCode.APIError>

func DispatchRequest<T1>(_ r1: ConcurrentAPIRequest<T1>) -> Observable<APIResult<T1>> {
    return api.sendSingleRequestRxWithIdentifier(r1)
}

func DispatchRequests<T1, T2>(_ r1: ConcurrentAPIRequest<T1>, _ r2: ConcurrentAPIRequest<T2>) -> Observable<(Observable<APIResult<T1>>.Element, Observable<APIResult<T2>>.Element)> {
    return Observable.combineLatest(api.sendSingleRequestRxWithIdentifier(r1),
                                    api.sendSingleRequestRxWithIdentifier(r2))
}

func DispatchRequests<T1, T2, T3>(_ r1: ConcurrentAPIRequest<T1>, _ r2: ConcurrentAPIRequest<T2>, _ r3: ConcurrentAPIRequest<T3>) -> Observable<(Observable<APIResult<T1>>.Element, Observable<APIResult<T2>>.Element, Observable<APIResult<T3>>.Element)> {
    return Observable.combineLatest(api.sendSingleRequestRxWithIdentifier(r1),
                                    api.sendSingleRequestRxWithIdentifier(r2),
                                    api.sendSingleRequestRxWithIdentifier(r3))
}

func DispatchRequests<T1, T2, T3, T4>(_ r1: ConcurrentAPIRequest<T1>, _ r2: ConcurrentAPIRequest<T2>, _ r3: ConcurrentAPIRequest<T3>, _ r4: ConcurrentAPIRequest<T4>) -> Observable<(Observable<APIResult<T1>>.Element, Observable<APIResult<T2>>.Element, Observable<APIResult<T3>>.Element, Observable<APIResult<T4>>.Element)> {
    return Observable.combineLatest(api.sendSingleRequestRxWithIdentifier(r1),
                                    api.sendSingleRequestRxWithIdentifier(r2),
                                    api.sendSingleRequestRxWithIdentifier(r3),
                                    api.sendSingleRequestRxWithIdentifier(r4))
}

func APIResultToViewResult<T>(apiResult: APIResult<T>) -> ViewResult<T>{
    switch apiResult{
    case .success(let result):
        return ViewResult(object: result.data)
    case .failure(let error):
        //Note: Switch to a generalized APIResponse Code that can be passed then later converted back and output
        return ViewResult(errorCode: APIResponseCode.Error(error))
    }
}

///Just to limit how much we are writing "Binding"
typealias ViewBinder<T> = Binding<ViewResult<T>>
typealias RequestBinder<T> = (APIRequest<T>, ViewBinder<T>)

///This class is used for basic Views, who just want to grab data and do not need to publish variables. This is less cumbersome than setting up
///and entire VM for it.
class ViewBindAPIDispatcher {
    
    private var bag = DisposeBag()
    
    //Generally used for response codes
    func SendRequest<T1>(_ r1: APIRequest<T1>, resultHandler: @escaping (APIResult<T1>) -> Void) {
        DispatchRequest(ConcurrentAPIRequest(request: r1))
            .subscribe(onNext: { result in
                resultHandler(result)
            }).disposed(by: bag)
    }
    
    func SendRequest<T1>(_ r1: RequestBinder<T1>){
        DispatchRequest(ConcurrentAPIRequest(request: r1.0))
            .subscribe(onNext: { result in
                r1.1.wrappedValue = APIResultToViewResult(apiResult: result)
            }).disposed(by: bag)
    }
    
    func SendRequests<T1, T2>(_ r1: RequestBinder<T1>, _ r2: RequestBinder<T2>) {
        DispatchRequests(ConcurrentAPIRequest(request: r1.0), ConcurrentAPIRequest(request: r2.0))
            .subscribe(onNext: { result in
                r1.1.wrappedValue = APIResultToViewResult(apiResult: result.0)
                r2.1.wrappedValue = APIResultToViewResult(apiResult: result.1)
            }).disposed(by: bag)
    }
    
    func SendRequests<T1, T2, T3>(_ r1: RequestBinder<T1>, _ r2: RequestBinder<T2>, _ r3: RequestBinder<T3>) {
        DispatchRequests(ConcurrentAPIRequest(request: r1.0), ConcurrentAPIRequest(request: r2.0), ConcurrentAPIRequest(request: r3.0))
            .subscribe(onNext: { result in
                r1.1.wrappedValue = APIResultToViewResult(apiResult: result.0)
                r2.1.wrappedValue = APIResultToViewResult(apiResult: result.1)
                r3.1.wrappedValue = APIResultToViewResult(apiResult: result.2)
            }).disposed(by: bag)
    }
    
    func SendRequests<T1, T2, T3, T4>(_ r1: RequestBinder<T1>, _ r2: RequestBinder<T2>, _ r3: RequestBinder<T3>, _ r4: RequestBinder<T4>) {
        DispatchRequests(ConcurrentAPIRequest(request: r1.0), ConcurrentAPIRequest(request: r2.0), ConcurrentAPIRequest(request: r3.0), ConcurrentAPIRequest(request: r4.0))
            .subscribe(onNext: { result in
                r1.1.wrappedValue = APIResultToViewResult(apiResult: result.0)
                r2.1.wrappedValue = APIResultToViewResult(apiResult: result.1)
                r3.1.wrappedValue = APIResultToViewResult(apiResult: result.2)
                r4.1.wrappedValue = APIResultToViewResult(apiResult: result.3)
            }).disposed(by: bag)
    }
}

class ViewModelAPIDispatcher {
    
    private var bag = DisposeBag()
    
    //Returns an API result that is generally handled by the .SetData() function defined in ViewResult.
    //Primary use is API Calls that expect a response code in return. (IE: 200, 201, 203, etc)
    func SendRequest<T1>(_ r1: APIRequest<T1>, resultHandler: @escaping (APIResult<T1>) -> Void) {
        DispatchRequest(ConcurrentAPIRequest(request: r1))
            .subscribe(onNext: { result in
                resultHandler(result)
            }).disposed(by: bag)
    }
    
    //Returns an API result with the expectaion that data is returned that will update UI.
    //Need to send to the main thread to update UI.
    func SendRequestViewUpdate<T1>(_ r1: APIRequest<T1>, resultHandler: @escaping (APIResult<T1>) -> Void) {
        DispatchRequest(ConcurrentAPIRequest(request: r1))
            .subscribe(
                onNext: { result in
                    DispatchQueue.main.async {
                        resultHandler(result)
                    }
                }
            ).disposed(by: bag)
    }
    
    //Returns a value for a direct binding. This should be used sparingly in cases where a ViewModel is passed to a child view
    //and the child view is relativley simple and should not require its own VM.
    func SendRequestBindUpdate<T1>(_ r1: APIRequest<T1>, resultHandler: @escaping CompletionHandler<T1>) {
        DispatchRequest(ConcurrentAPIRequest(request: r1))
            .subscribe(onNext: { result in
                switch result{
                case .success(let data):
                    resultHandler(data.data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }).disposed(by: bag)
    }
    
    func SendRequests<T1, T2>(_ r1: APIRequest<T1>, _ r2: APIRequest<T2>, resultHandler: @escaping (APIResult<T1>, APIResult<T2>) -> Void) {
        DispatchRequests(ConcurrentAPIRequest(request: r1), ConcurrentAPIRequest(request: r2))
            .subscribe(onNext: { result in
                resultHandler(result.0, result.1)
            }).disposed(by: bag)
    }
    
    func SendRequests<T1, T2, T3>(_ r1: APIRequest<T1>, _ r2: APIRequest<T2>, _ r3: APIRequest<T3>, resultHandler: @escaping (APIResult<T1>, APIResult<T2>, APIResult<T3>) -> Void) {
        DispatchRequests(ConcurrentAPIRequest(request: r1), ConcurrentAPIRequest(request: r2), ConcurrentAPIRequest(request: r3))
            .subscribe(onNext: { result in
                resultHandler(result.0, result.1, result.2)
            }).disposed(by: bag)
    }

    func SendRequests<T1, T2, T3, T4>(_ r1: APIRequest<T1>, _ r2: APIRequest<T2>, _ r3: APIRequest<T3>, _ r4: APIRequest<T4>, resultHandler: @escaping (APIResult<T1>, APIResult<T2>, APIResult<T3>, APIResult<T4>) -> Void) {
        DispatchRequests(ConcurrentAPIRequest(request: r1), ConcurrentAPIRequest(request: r2), ConcurrentAPIRequest(request: r3), ConcurrentAPIRequest(request: r4))
            .subscribe(onNext: { result in
                resultHandler(result.0, result.1,result.2, result.3)
            }).disposed(by: bag)
    }
    
}
