//
//  LocationManagerDelegate.swift
//  Diary
//
//  Created by 조호준 on 2023/09/14.
//

protocol LocationManagerDelegate: AnyObject {
    func fetchWeatherData(latitude: String, longitude: String)
}
