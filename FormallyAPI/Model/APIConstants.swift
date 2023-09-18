//
//  APIConstants.swift
//  FormallyAPI
//
//  Created by imac-2437 on 2023/8/16.
//

import Foundation

public struct NewWorkConstants {
    static let httpBaseUrl = "http://"
    static let httpsBaseUrl = "https://"
    
    //網域名稱
    static let appServer = "opendata.cwb.gov.tw"
}

public enum HttpHeaderField: String {
    
    case autentication = "Autentication"
    
    case contentType = "Content-Type"
    
    case acceptType = "Accept"
    
    case acceptEncoding = "Accept-Encoding"
}

public enum ContenType: String {
    case json = "application/json"
    
    case xml = "application/xml"
    
    case x_www_form_urlencoded = "application/x-www-form-urlencoded"
}


public enum HttpMethod: String {
    case option = "OPTION"
    
    case get = "GET"
    
    case head = "HEAD"
    
    case post = "POST"
    
    case put = "PUT"
    
    case patch = "PATCH"
    
    case delete = "DELETE"
    
    case trace = "TRACE"
    
    case connect = "CONNECT"
}

public enum RequestError: Error {
    case unknownError(Error)
    case connectionError
    case invalidResponse
    case jsonDecodeFailed(Error)
    case invalidRequest  //400
    case authorizationError //401
    case notFound //404
    case internalError //500
    case serverError //502
    case serverUnavailable  //503
    
}

public enum ApiPathConstantse: String {
    case hour36 = "/api/v1/rest/datastore/F-C0032-001"
}
