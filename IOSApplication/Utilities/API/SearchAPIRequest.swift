//
//  SearchAPIRequest.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/29/24.
//

import Foundation

/* Custom struct to quickly make api calls depending on an input string
   The struct assumes that the returned value will be in a list, as that is the essence of a search
   We will only allow one search value but it can be used to search multiple fields */
class SearchAPIRequest<Result> where Result : Decodable {
    var urlComponents: URLComponents
    var queryFields: [URLQueryItem]
    var handleResponse: (Data) throws -> Result
    var currentSearch: String
    let baseUrl: String = "http://127.0.0.1:8000"
    
    init(endpoint: String, searchableFields: [String]) {
        
        self.urlComponents = URLComponents(string: baseUrl)!
        self.urlComponents.path = endpoint
        self.currentSearch = ""
        self.queryFields = []
        
        //Initialize search query for each parameter to be an empty string
        //By default we are searching all fields
        for field in searchableFields {
            queryFields.append(URLQueryItem(name: field, value: self.currentSearch))
        }
        self.urlComponents.queryItems = self.queryFields

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        self.handleResponse = { try decoder.decode(Result.self, from: $0) }
        
    }
}

extension SearchAPIRequest where Result : Decodable {
    
    ///Converts current state of SearchAPIRequest to one that's is sent to tehe backend.
    func asSendableRequest() -> SendableSearchRequest<Result> {
        return (URLRequest(url: self.urlComponents.url!), self.handleResponse)
    }
    
    ///Adds a new field to search within the database. Should be defined as an Enum with string literals that have values that are in the database.
    func addSearchField(newParameter: String) -> Void {
        self.queryFields.append(URLQueryItem(name: newParameter, value: self.currentSearch))
        self.urlComponents.queryItems = self.queryFields
    }
    
    ///Removes a field from the search. Should be defined as an Enum with string literals that have values that are in the database.
    func removeSearchField(field: String) -> Void {
        self.queryFields.removeAll(where: { $0.name == field})
        self.urlComponents.queryItems = self.queryFields
    }
    
    ///Updates the state of the object for to perfrom a new query.
    func updateSearch(newQuery: String) {
        
        //We don't want to search any terms if it is empty
        //But we don't want to clear filter parameters, might be a better way to do this.
        if newQuery.isEmpty {
            self.urlComponents.queryItems = []
            
        } else {
            //Update each query item
            for index in 0..<self.queryFields.count {
                self.queryFields[index].value = newQuery
            }
            
            //Update URLComponents
            self.urlComponents.queryItems = queryFields
            
        }
        
        //Update query search and URLComponents
        self.currentSearch = newQuery
        
    }
    
}
