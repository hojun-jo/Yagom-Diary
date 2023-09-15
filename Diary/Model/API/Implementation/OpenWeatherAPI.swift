//
//  OpenWeatherAPI.swift
//  Diary
//
//  Created by 조호준 on 2023/09/14.
//

import Foundation

struct OpenWeatherAPI: APIType {
    var baseURL = "https://api.openweathermap.org/data/2.5/weather"
    var queryItems: [URLQueryItem]?
    private let apiKey = Bundle.openWeatherAPIKey
    
    init(latitude: String, longitude: String) {
        queryItems = [
            URLQueryItem(name: "lat", value: latitude),
            URLQueryItem(name: "lon", value: longitude),
            URLQueryItem(name: "appid", value: apiKey)
        ]
    }
}
