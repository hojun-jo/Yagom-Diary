//
//  NetworkError.swift
//  Diary
//
//  Created by 조호준 on 2023/09/14.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case dataTaskFail
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .dataTaskFail:
            return "데이터 테스크가 실패했습니다."
        case .invalidResponse:
            return "유효하지 않은 응답입니다."
        case .invalidData:
            return "유효하지 않은 데이터입니다."
        }
    }
}
