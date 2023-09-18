//
//  APIData.swift
//  FormallyAPI
//
//  Created by imac-2437 on 2023/8/16.
//

import Foundation

public func requestData<E,D> (method: HttpMethod, path: ApiPathConstantse, parameters: E?) async throws -> D where E: Encodable, D: Decodable {
    let UrlRequest = handelHttpMethod(method: method, path: path, parameter: parameters)
    do {
        let (data, response) = try await URLSession.shared.data(for: UrlRequest)
        guard let response = (response as? HTTPURLResponse) else {
            throw RequestError.invalidResponse
        }
        
        let statusCodes = response.statusCode
        print("\(statusCodes)")
        
        guard (200...299).contains(statusCodes) else {
            switch statusCodes {
            case 400:
                throw RequestError.invalidResponse
            case 401:
                throw RequestError.authorizationError
            case 404:
                throw RequestError.notFound
            case 500:
                throw RequestError.internalError
            case 502:
                throw RequestError.serverError
            case 503:
                throw RequestError.serverUnavailable
            default:
                throw RequestError .invalidResponse
            }
        }
        do {
            let result = try JSONDecoder().decode(D.self, from: data)
            
            #if DEBUG
            printNetworkProgress(urlRequest: UrlRequest, parameters: parameters, results: result)
            #endif
            
            return result
        } catch {
            throw RequestError.jsonDecodeFailed(error as! DecodingError)
        }
    }catch {
        print(error.localizedDescription)
        throw RequestError.unknownError(error)
    }
}

private func handelHttpMethod <E: Encodable>(method: HttpMethod, path: ApiPathConstantse, parameter: E?) -> URLRequest {
    let baseUrl = NewWorkConstants.httpsBaseUrl + NewWorkConstants.appServer + path.rawValue
    let url = URL(string: baseUrl)
    var urlRequest = URLRequest (url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
    let httpType = ContenType.json.rawValue
    urlRequest.allHTTPHeaderFields = [HttpHeaderField.contentType.rawValue : httpType]
    urlRequest.httpMethod = method.rawValue
    
    let dicl = try? parameter.asDictionary()
    
    switch method {
    case .get:
        let parameters = dicl as? [String : String]
        urlRequest.url = requestwithURL(urlString: urlRequest.url?.absoluteString ?? "",parameters: parameters ?? [:])
    default:
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: dicl ?? [:], options: .prettyPrinted)
    }
    return urlRequest
}

private func requestwithURL (urlString: String, parameters: [String : String]?) -> URL? {
    guard var urlComponents = URLComponents (string: urlString) else {return nil}
    urlComponents.queryItems = [ ]
    parameters?.forEach({ (key, value) in
        urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
    })
    return urlComponents.url
}

private func printNetworkProgress<E, D>(urlRequest: URLRequest,
                                        parameters: E,
                                        results: D) where E: Encodable, D: Decodable {
    #if DEBUG
    print("=======================================")
    print("- URL: \(urlRequest.url?.absoluteString ?? "")")
    print("-Header:\(urlRequest.allHTTPHeaderFields ?? [:])")
    print("---------------Request----------------")
    print (parameters)
    print ("--------------Response---------------")
    print (results)
    print("======================================")
    #endif
}
