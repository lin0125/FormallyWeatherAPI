//
//  WeatherResponse.swift
//  WeatherAPI
//
//  Created by imac-2437 on 2023/8/16.
//

import Foundation

struct WeatherRequest: Encodable {
    var Authorization: String
    var locationName: String
}

struct WeatherResponse: Codable {
    var success: String
    var result: resource
    var records: record
}

struct resource: Codable {
    var resource_id: String
    var fields: [field]
}

struct field: Codable {
    var id: String
    var type: String
}

struct record: Codable {
    var datasetDescription: String
    var location: [locations]
}

struct locations: Codable {
    var locationName: String
    var weatherElement: [weatherElements]
}

struct weatherElements: Codable {
    var elementName: String
    var time: [times]
}

struct times: Codable {
    var startTime: String
    var endTime: String
    var parameter: parameters
}

struct parameters: Codable {
    var parameterName: String
    var parameterValue: String?
    var parameterUnit: String?
}

