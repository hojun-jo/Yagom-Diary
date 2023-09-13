//
//  APIType.swift
//  Diary
//
//  Created by 조호준 on 2023/09/14.
//

import Foundation

protocol APIType {
    var baseURL: String { get }
    var queryItems: [URLQueryItem]? { get }
    var apiKey: String { get }
}
